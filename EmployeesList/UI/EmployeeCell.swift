//
//  EmployeeCell.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    var imageService: ImageService?
    private var imageRequest: Cancellable?

    private let nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let employeeTypeLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let emailLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let teamLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
    
    private let employeeImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "unknown")
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        employeeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            employeeImageView.heightAnchor.constraint(equalToConstant: 80),
            employeeImageView.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 4
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(teamLabel)
        labelsStackView.addArrangedSubview(employeeTypeLabel)
        labelsStackView.addArrangedSubview(emailLabel)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        stackView.addArrangedSubview(employeeImageView)
        stackView.addArrangedSubview(labelsStackView)
    }
    
    func configure(_ model: Employee) {
        self.nameLabel.text = model.name
        self.teamLabel.text = "Team: " + model.team
        self.emailLabel.text = model.email
        self.employeeTypeLabel.text = "Type: " + model.employeeType.title
        guard let imageURL = model.photoURL else {
            return
        }
        imageRequest = imageService?.loadImage(url: imageURL, completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.employeeImageView.image = image
                self?.employeeImageView.makeRounded()
            }
        })
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        employeeImageView.image = UIImage(named: "unknown")
        imageRequest?.cancel()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
