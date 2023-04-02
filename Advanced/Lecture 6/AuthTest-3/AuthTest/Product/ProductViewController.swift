//
//  ProductViewController.swift
//  AuthTest
//
//  Created by e.korotkiy on 14.03.2023.
//  
//

import UIKit

final class ProductViewController: UIViewController {
    private let productImageView = UINetworkImageView()
    private let productTitleLabel: UILabel = UILabel()
    
    private let output: ProductViewOutput

    init(output: ProductViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        productImageView.contentMode = .scaleAspectFit
        productImageView.backgroundColor = .systemGray5
        
        productTitleLabel.numberOfLines = 0
        
        view.addSubview(productImageView)
        view.addSubview(productTitleLabel)
        
        output.didLoadView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        productImageView.pin
            .top()
            .horizontally()
            .height(300)
        
        productTitleLabel.pin
            .below(of: productImageView)
            .marginTop(30)
            .horizontally(15)
            .sizeToFit(.width)
    }
}

extension ProductViewController: ProductViewInput {
    func configure(with model: ProductViewModel) {
        productTitleLabel.text = model.title
        
        productImageView.load(from: model.imageURL)
    }
    
}
