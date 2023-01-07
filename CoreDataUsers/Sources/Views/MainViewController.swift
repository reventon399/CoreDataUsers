//
//  ViewController.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 05.12.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var names = ["Ivan Petrov", "John Smith", "Igor Smirnov"]
    
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
        view.backgroundColor = .white
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupHierarchy()
        setupLayout()
    }

    
    // MARK: - Setup
    
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
//            make.right.bottom.left.equalTo(view)
        }
    }

    // MARK: - Actions
    
    @objc private func addButtonPressed() {
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailViewController()
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            names.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
