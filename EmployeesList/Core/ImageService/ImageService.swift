//
//  ImageService.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import UIKit

protocol ImageService {
    /// Loading image of employee
    @discardableResult func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable?
}

final class ImageServiceImpl: ImageService {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    @discardableResult func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable? {
        guard url.pathComponents.count >= 2 else {
            print("Invalid image URL")
            return nil
        }
        let fileName = url.pathComponents.reversed()[0..<2].joined(separator: "-")
        let fileURL = self.getDocumentsDirectory().appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            let image = UIImage(contentsOfFile: fileURL.path)
            completion(image)
            return nil
        }
        let request = NetworkRequest(url: url.absoluteString)
        let task = networkService.send(request) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    try? data.write(to: fileURL)
                    completion(image)
                }
            case .failure(let error):
                print("Fail to load an image with URL: \(url) error:\(String(describing: error)).")
                completion(nil)
            }
        }
        return task
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
