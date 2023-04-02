//
//  ProductsListViewController.swift
//  AuthTest
//
//  Created by Artur Sardaryan on 28.02.2023.
//  
//

import UIKit

final class ProductCollectionViewController: UIViewController {
    private let output: ProductCollectionViewOutput
    private let refreshControl: UIRefreshControl = UIRefreshControl()

    init(output: ProductCollectionViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collection
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        output.didLoadView()
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.pin.all()
    }
}

extension ProductCollectionViewController: ProductCollectionViewInput {
    func reloadData() {
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
}

// MARK: - Constnants

private extension ProductCollectionViewController {
    
    struct Constants {
        static let cellOffset: CGFloat = 8
        static let cellHeight: CGFloat = 240
        static let numberOfItemsPerRow: CGFloat = 2
    }
}

// MARK: - Setups

private extension ProductCollectionViewController {
    
    func setupPullToRefresh() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        collectionView.refreshControl = refreshControl
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(ProductCollectionViewCell.self)
    }
    
    func setupCommon() {
        title = "Мои товары"
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    func setup() {
        setupCommon()
        setupPullToRefresh()
        setupCollectionView()
    }
}

// MARK: - Actions

private extension ProductCollectionViewController {
    
    @objc
    func didPullToRefresh() {
        output.reloadData()
    }
}

// MARK: - UICollectionView DataSource/Delegate/FlowLayout

extension ProductCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ProductCollectionViewCell.self, for: indexPath)
        
        let product: Product = output.item(at: indexPath.row)
        
        cell.configure(with: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width - Constants.cellOffset * (Constants.numberOfItemsPerRow + 1)
        let cellWidth = availableWidth / Constants.numberOfItemsPerRow
        
        return .init(width: cellWidth, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .init(top: 0, left: Constants.cellOffset, bottom: 0, right: Constants.cellOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constants.cellOffset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return Constants.cellOffset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItem(at: indexPath.row)
    }
}
