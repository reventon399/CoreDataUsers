//
//  ModuleBuilder.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 30.12.2022.
//

import Foundation
import UIKit

protocol BuilderType {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(model: Person, router: RouterProtocol) -> UIViewController
}

final class ModuleBuilder: BuilderType {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(model: Person, router: RouterProtocol) -> UIViewController {
        let person = model
        let view = DetailViewController()
        let presenter = DetailPresenter(person: person, view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    
}
