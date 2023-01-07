//
//  DetailedPresenter.swift
//  CoreDataUsers
//
//  Created by Алексей Лосев on 02.01.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setupDetailView(name: String, gender: String?, dateOfBirth: Date?, image: Data?)
}

protocol DetailPresenterProtocol: AnyObject {
    func setData()
    func returnToMainView()
    func updateData(name: String, gender: String?, dateOfBirth: Date?, image: Data?)
}

class DetailPresenter: DetailPresenterProtocol {
    
    var person: Person?
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    
    required init(person: Person, view: DetailViewProtocol, router: RouterProtocol) {
        self.person = person
        self.view = view
        self.router = router
    }
    
    func setData() {
        let name = person?.name ?? ""
        let gender = person?.gender ?? nil
        let dateOfBirth = person?.dateOfBirth ?? nil
        let image = person?.image ?? nil
        self.view?.setupDetailView(name: name,
                                   gender: gender,
                                   dateOfBirth: dateOfBirth,
                                   image: image)
    }
    
    func returnToMainView() {
        router?.returnToRoot()
    }
    
    func updateData(name: String, gender: String?, dateOfBirth: Date?, image: Data?) {
        CoreDataManager.shared.updatePerson(name: name ,
                                            dateOfBirth: dateOfBirth ?? nil,
                                            gender: gender ?? "",
                                            image: image ?? nil)
    }
}
