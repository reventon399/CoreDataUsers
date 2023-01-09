//
//  ViewController.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 05.12.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    
    // MARK: - Outlets
    
    private lazy var userTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Print your name here"
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Press", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = userTextField.layer.cornerRadius
        button.addTarget(self, action: #selector(addButtonPressed) , for: .touchUpInside)
        return button
    }()
    
    private lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var userTextFieldAndAddButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupHierarchy()
        setupLayout()
        presenter?.fetchUsers()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        view.backgroundColor = .white
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupHierarchy() {
        view.addSubview(userTextFieldAndAddButtonStack)
        userTextFieldAndAddButtonStack.addArrangedSubview(userTextField)
        userTextFieldAndAddButtonStack.addArrangedSubview(addButton)
        view.addSubview(usersTableView)
    }
    
    private func setupLayout() {
        userTextFieldAndAddButtonStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(120)
        }
        
        usersTableView.snp.makeConstraints { make in
            make.top.equalTo(userTextFieldAndAddButtonStack.snp.bottom).offset(50)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Actions
    
    @objc private func addButtonPressed() {
        guard let name = userTextField.text, name != "" else { return showAlert() }
        presenter?.savePerson(name: name)
        userTextField.text = ""
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Empty text field", message: "type name then press button", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK!", style: .cancel))
        self.present(alert, animated: true)
    }
}

// MARK: - Extensions

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getNumberOfRows() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = presenter?.getName(index: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showDetailedPerson(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            presenter?.deleteTableViewCell(index: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

extension MainViewController: MainViewType {
    func reloadTable() {
        usersTableView.reloadData()
    }
}
