//
//  Presenter.swift
//  VIPER
//
//  Created by emil kurbanov on 12.09.2022.
//

import Foundation
enum ErrorFetch: Error {
    case failed
}
protocol AnyPresenter {
    var view: AnyView? { get set }
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    func getFetchUser(with result: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var view: AnyView?
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.load()
        }
    }
    
    func getFetchUser(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.upLoad(with: users)
        case .failure:
            view?.upLoad(with: "Что-то пошло не так =(")
        }
    }
    
    
}
