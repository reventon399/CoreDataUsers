//
//  DetailViewController.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 25.12.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: nil
        )
    }
}
