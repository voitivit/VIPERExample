//
//  Interactor.swift
//  VIPER
//
//  Created by emil kurbanov on 12.09.2022.
//https://jsonplaceholder.typicode.com/users

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func load()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func load() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                self.presenter?.getFetchUser(with: .failure(ErrorFetch.failed))
                return
            }
            do {
                let json = try JSONDecoder().decode([User].self, from: data)
                self.presenter?.getFetchUser(with: .success(json))
            } catch  {
                self.presenter?.getFetchUser(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
}
