//
//  ViewController.swift
//  VK Services
//
//  Created by Artur Sardaryan on 13.12.2022.
//

import UIKit
import SafariServices
import PinLayout

class ViewController: UIViewController {
    private let tableView = UITableView()
    private let networkManager = NetworkManager.shared
    
    private let refreshControl = UIRefreshControl()
    
    private var services: [Service] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadData()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ServiceCell.self, forCellReuseIdentifier: "ServiceCell")
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.frame
    }
    
    private func loadData(fromPullToRefresh: Bool = false) {
        self.networkManager.loadServices { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let services):
                    self?.services = services
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
                if fromPullToRefresh {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
        
    @objc
    private func didPullToRefresh() {
        loadData(fromPullToRefresh: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell") as? ServiceCell else {
            return .init()
        }
        
        let service = services[indexPath.row]

        cell.accessoryType = .disclosureIndicator
        cell.configure(with: service)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = services[indexPath.row]
        
        guard let url = URL(string: service.link) else {
            return
        }
        
//        UIApplication.shared.open(url)
        
        let viewController = SFSafariViewController(url: url)
        viewController.modalPresentationStyle = .pageSheet
        present(viewController, animated: true)
    }
}
