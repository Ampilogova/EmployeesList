//
//  EmployeesViewController.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import UIKit

class EmployeesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var employees = [Employee]()
    private let imageService: ImageService
    private let employeeService: EmployeesService
    private var employeesRequest: Cancellable?
    
    private let refreshControl = UIRefreshControl()
    private lazy var tableView = UITableView(frame: view.frame, style: .plain)
    
    init(employeeService: EmployeesService, imageService: ImageService) {
        self.employeeService = employeeService
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupNavigationBar()
        setupTableView()
        loadEmployess()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "Employees"
    }
    
    private func setupTableView() {
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.className)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        view.addSubview(tableView)
    }

    private func loadEmployess() {
        employeesRequest?.cancel()
        employeesRequest = employeeService.loadEmployees { [weak self] result in
            switch result {
            case .success(let employees):
                self?.employees = employees
                DispatchQueue.main.async {
                    if employees.isEmpty {
                        self?.tableView.setEmptyMessage("Employee list is empty for now.")
                    } else {
                        self?.tableView.cleanEmptyMessage()
                    }
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: error.localizedDescription, handler: {
                        self?.refreshControl.endRefreshing()
                    })
                }
            }
        }
    }
    
    // MARK: - UITableViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.className, for: indexPath) as! EmployeeCell
        let employee = employees[indexPath.row]
        cell.imageService = imageService
        cell.configure(employee)
        return cell
    }
    
    //MARK: - Actions
    
    @objc private func refresh() {
        loadEmployess()
    }
}
