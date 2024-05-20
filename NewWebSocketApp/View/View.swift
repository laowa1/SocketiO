//
//  View.swift
//  NewWebSocketApp
//
//  Created by Bender on 20.05.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showItems(_ items: [Item])
}

class MainView: UIView {
    var tableView: UITableView!
    var connectButton: UIButton!
    var disconnectButton: UIButton!
    var buttonStackView: UIStackView!
    
    var presenter: MainPresenterProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addSubview(tableView)
        
        connectButton = UIButton(type: .system)
        connectButton.setTitle("Connect", for: .normal)
        connectButton.addTarget(self, action: #selector(connectButtonTapped), for: .touchUpInside)
        
        disconnectButton = UIButton(type: .system)
        disconnectButton.setTitle("Disconnect", for: .normal)
        disconnectButton.addTarget(self, action: #selector(disconnectButtonTapped), for: .touchUpInside)
        
        buttonStackView = UIStackView(arrangedSubviews: [connectButton, disconnectButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.backgroundColor = .white
        buttonStackView.spacing = 10
        addSubview(buttonStackView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
            
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            buttonStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func connectButtonTapped() {
        presenter.connectSocket()
    }
    
    @objc func disconnectButtonTapped() {
        presenter.disconnectSocket()
    }
}

extension MainView: MainViewProtocol {
    func showItems(_ items: [Item]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
