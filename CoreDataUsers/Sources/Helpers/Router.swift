//
//  Router.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 30.12.2022.
//

import Foundation
import UIKit

protocol RouterType {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: BuilderType? { get set }
}

protocol RouterProtocol: RouterType {
    func initialViewController()
    func showDetailedPerson(person: Person)
    func returnToRoot()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: BuilderType?
    
    init(navigationController: UINavigationController, assemblyBuilder: BuilderType) {
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
        guard let detailedViewController = assemblyBuilder?.createDetailModule(model: person, router: self) else { return }
        navigationController.pushViewController(detailedViewController, animated: true)
    }
    
    func returnToRoot() {
        guard let navigationController = navigationController else { return }
        navigationController.popToRootViewController(animated: true)
    }
    
    
    
}
