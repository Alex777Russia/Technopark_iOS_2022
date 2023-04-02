//
//  ViewController.swift
//  VKTest
//
//

import UIKit
import PinLayout

class ServicesViewController: UIViewController {
    let tableView = UITableView()
    
    var services: [Service] = []
    
    let dataURL = "https://publicstorage.hb.bizmrg.com/sirius/result.json"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        loadData() {
            self.tableView.reloadData()
        }
    }
    
    private func setup() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceTableViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin.all()
    }
    
    private func loadData(compl: (() -> Void)? = nil) {
        NetworkManager.shared.loadServices(urlString: dataURL) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let servicesData):
                    print("Success!")
                    self?.services = [servicesData.body.services, servicesData.body.services, servicesData.body.services, servicesData.body.services, servicesData.body.services].flatMap({ $0 })
                    self?.tableView.reloadData()
                    break
                    
                case .failure(let error):
                    print("Error! \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel)
                        alertController.addAction(okAction)
                        self?.present(alertController, animated: true, completion: nil)
                    break
                }
                compl?()
            }
        }
    }
}

extension ServicesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as? ServiceTableViewCell else {
            return UITableViewCell()
        }
        
        let service = services[indexPath.row]
        cell.configure(with: service)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = ServiceTableViewCell()
        
        let service = services[indexPath.row]
        cell.configure(with: service)
        
        let height = cell.sizeThatFits(tableView.bounds.size).height
        
        return height
    }
}

