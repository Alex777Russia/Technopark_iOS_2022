//
//  ViewController.swift
//  WeatherApp
//
//  Created by Artur Sardaryan on 08.11.2022.
//

import UIKit
import PinLayout


class ViewController: UIViewController {
    
    private let tableView = UITableView()
    private var models: [CellModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.rowHeight = 40
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        
        tableView.separatorInset = .zero
        
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        title = "Weather App"
    }
    
    private func addCity(with title: String) {
        NetworkManager.shared.loadWeather(for: title) { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let cityResponse):
                    let model = CellModel(with: cityResponse)
                    self.models.append(model)
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: [IndexPath(row: self.models.count - 1, section: 0)], with: .left)
                    self.tableView.endUpdates()
                case .failure(let error):
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
                    alertController.addAction(cancelAction)

                    self.present(alertController, animated: true)
                }
            }
        }
    }

    @objc
    private func didTapAddButton() {
        let alertController = UIAlertController(title: "Add city", message: "Enter city name", preferredStyle: .alert)

        alertController.addTextField()

        let okAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let text = alertController.textFields?.first?.text else {
                return
            }
            
            self?.addCity(with: text)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as? MyTableViewCell
        
        cell?.configure(with: models[indexPath.row])
        
        return cell ?? .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewContller = UIViewController()
        viewContller.title = models[indexPath.row].title
        viewContller.view.backgroundColor = .systemBackground
        let navigationController = UINavigationController(rootViewController: viewContller)
        present(navigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        
        if indexPath.row == models.count - 1 {
            print("This is the end")
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function, indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
