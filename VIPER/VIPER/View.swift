//
//  UserView.swift
//  VIPER
//
//  Created by emil kurbanov on 12.09.2022.
//

import UIKit
protocol AnyView {
    var presenter: AnyPresenter? { get set }
    func upLoad(with user: [User])
    func upLoad(with error: String)
}

class UserView: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    var user: [User] = []
    var presenter: AnyPresenter?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    let labelError: UILabel = {
        let labelError = UILabel()
        labelError.textAlignment = .center
        labelError.isHidden = true
        return labelError
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(labelError)
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        labelError.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        labelError.center = view.center
    }
    func upLoad(with user: [User]) {
        DispatchQueue.main.async {
            self.user = user
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.labelError.isHidden = true
        }
    }
    
    func upLoad(with error: String) {
        DispatchQueue.main.async {
            self.user = []
            self.tableView.isHidden = true
            self.labelError.text = error
            self.labelError.isHidden = false
        }
    }
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = user[indexPath.row].name
        return cell
    }
}

