//
//  Router.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 30.12.2022.
//

import Foundation
import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailedPerson(person: Person)
    func returnToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: BuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: BuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        guard let navigationController = navigationController else { return }
        guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
        navigationController.viewControllers = [mainViewController]
    }
    
    func showDetailedPerson(person: Person) {
        guard let navigationController = navigationController else { return }
        guard let detailedViewController = assemblyBuilder?.createDetailModule(person: person, router: self) else { return }
        navigationController.pushViewController(detailedViewController, animated: true)
    }
    
    func returnToRoot() {
        guard let navigationController = navigationController else { return }
        navigationController.popToRootViewController(animated: true)
    }
    
    
    
}
