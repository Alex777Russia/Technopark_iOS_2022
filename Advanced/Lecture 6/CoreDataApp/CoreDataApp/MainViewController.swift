//
//  MainViewController.swift
//  CoreDataApp
//
//  Created by e.korotkiy on 21.03.2023.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    private let tableView: UITableView = UITableView()
    
    private var items: [String] = []
    
    private lazy var frc: NSFetchedResultsController<Person> = {
        let request = Person.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Person.name),
                                              ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: request,
                                             managedObjectContext: DataManager.shared.mainQueueContex,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        
        frc.delegate = self
        
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        initStorage()
    }
    
    private func setup() {
        view.backgroundColor = .systemGray6
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAddButton))
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "UITableViewCellReuseId")
        
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.frame
    }
    
    private func initStorage() {
        DataManager.shared.initCoreData { [weak self] in
            debugPrint("[DEBUG]: CoreData Init on VC")
            self?.updateData()
            
            try? self?.frc.performFetch()
        }
    }
    
    private func updateData() {
        let persons: [Person] = DataManager.shared.fetch(with: Person.fetchRequest())
        
        items = persons.compactMap({ $0.name })
        
        tableView.reloadData()
    }
    
    @objc
    private func didTapAddButton() {
        DataManager.shared.create(with: "Person") { person in
            guard let person = person as? Person else {
                return
            }
            
            person.name = UUID().uuidString
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frc.sections?[section].objects?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellReuseId") else {
            return UITableViewCell()
        }
        
        let person = frc.object(at: indexPath)
        
        cell.textLabel?.text = person.name
        
        return cell
    }
}

extension MainViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let oldIndexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
