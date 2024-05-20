//
//  ViewController.swift
//  NewWebSocketApp
//
//  Created by Bender on 20.05.2024.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var mainView: MainView!
    var presenter: MainPresenterProtocol!
    
    override func loadView() {
        mainView = MainView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainPresenter(view: mainView)
        mainView.presenter = presenter
        
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = presenter.items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
}
