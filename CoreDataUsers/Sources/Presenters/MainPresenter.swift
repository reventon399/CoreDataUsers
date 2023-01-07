//
//  MainPresenter.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 07.01.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func reloadTable()
}

protocol MainPresenterProtocol: AnyObject {
    func fetchUsers()
    func getNumberOfRows() -> Int
    func getName(index: IndexPath) -> String
    func savePerson(name: String)
    func deleteTableViewCell(index: IndexPath)
    func showDetailedPerson(index: IndexPath)
}

final class MainPresenter: MainPresenterProtocol {
    
    var persons: [Person]?
    weak var view: MainViewProtocol?
    var router: RouterProtocol?
    
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    func fetchUsers() {
        persons = CoreDataManager.shared.fetchUsers()
        view?.reloadTable()
    }
    
    func getNumberOfRows() -> Int {
        guard let persons = persons else { return 0 }
        return persons.count
    }
    
    func getName(index: IndexPath) -> String {
        return persons?[index.row].name ?? ""
    }
    
    func savePerson(name: String) {
        CoreDataManager.shared.savePerson(personName: name)
        fetchUsers()
    }
    
    func deleteTableViewCell(index: IndexPath) {
        guard let person = persons?[index.row] else { return }
        CoreDataManager.shared.deletePerson(person: person)
        persons?.remove(at: index.row)
    }
    
    func showDetailedPerson(index: IndexPath) {
        guard let person = persons?[index.row] else { return }
        router?.showDetailedPerson(person: person)
    }
    
    
}
