//
//  ProfileViewController.swift
//  StudyApplication
//
//  Created by e.korotkiy on 01.11.2022.
//

import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let containerScrollView: UIScrollView = UIScrollView()
    private let avatarImage: UIImageView = UIImageView()
    private let nameTitle: UILabel = UILabel()
    private let surnameTitle: UILabel = UILabel()
    private let descriptionTitle: UILabel = UILabel()
    private let editButton: UIButton = UIButton()
    
    // MARK: - Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        avatarImage.image = UIImage(named: "avatar")
        avatarImage.layer.cornerRadius = Constans.AvatarImage.size.height / 2
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.clipsToBounds = true
        
        nameTitle.text = "Artur"
        nameTitle.font = UIFont(name: "Noteworthy", size: 32)
        nameTitle.textColor = .systemPink
        
        surnameTitle.text = "Sardaryan"
        surnameTitle.font = UIFont(name: "Noteworthy", size: 32)
        surnameTitle.textColor = .systemPink
        
        descriptionTitle.text = Constans.DescriptionTitle.text
        descriptionTitle.font = UIFont(name: "Menlo", size: 18)
        descriptionTitle.numberOfLines = 0
        descriptionTitle.textAlignment = .justified
        
        editButton.backgroundColor = .systemPink.withAlphaComponent(0.8)
        editButton.layer.cornerRadius = Constans.EditButton.cornerRadius
        editButton.setTitle("Edit", for: .normal)
        
        containerScrollView.addSubviews(avatarImage, nameTitle, surnameTitle, descriptionTitle)
        
        view.addSubviews(containerScrollView, editButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layout()
    }
    
    // MARK: - Setup
    
    private func setupNavBar() {
        let backButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapBackButton))
        
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.navigationBar.tintColor = .systemPink
        title = "Profile"
    }
    
    // MARK: - Layout
    
    private func layout() {
        editButton.pin
            .bottom()
            .marginBottom(view.safeAreaInsets.bottom + Constans.EditButton.marginBottom)
            .height(Constans.EditButton.height)
            .horizontally(Constans.EditButton.marginHorizontal)
        
        containerScrollView.pin
            .top()
            .marginTop(view.safeAreaInsets.top)
            .above(of: editButton)
            .horizontally()
        
        avatarImage.pin
            .top()
            .marginTop(Constans.AvatarImage.marginTop)
            .hCenter()
            .size(Constans.AvatarImage.size)
        
        nameTitle.pin
            .below(of: avatarImage)
            .marginTop(Constans.NameTitle.marginTop)
            .horizontally(Constans.NameTitle.marginHorizontal)
            .sizeToFit(.width)
        
        surnameTitle.pin
            .below(of: nameTitle)
            .marginTop(Constans.SurnameTitle.marginTop)
            .horizontally(Constans.SurnameTitle.marginHorizontal)
            .sizeToFit(.width)
        
        descriptionTitle.pin
            .below(of: surnameTitle)
            .marginTop(Constans.DescriptionTitle.marginTop)
            .horizontally(Constans.DescriptionTitle.marginHorizontal)
            .sizeToFit(.width)
        
        containerScrollView.contentSize = CGSize(width: view.frame.width,
                                                 height: descriptionTitle.frame.maxY +
                                                 Constans.ContainerScrollView.marginBottom)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton() {
        dismiss(animated: true)
    }
}

// MARK: - Constants

private extension ProfileViewController {
    struct Constans {
        struct ContainerScrollView {
            static let marginBottom: CGFloat = 16
        }
        
        struct AvatarImage {
            static let marginTop: CGFloat = 10
            static let size: CGSize = CGSize(width: 150, height: 150)
        }
        
        struct NameTitle {
            static let marginTop: CGFloat = 16
            static let marginHorizontal: CGFloat = 32
        }
        
        struct SurnameTitle {
            static let marginTop: CGFloat = 4
            static let marginHorizontal: CGFloat = 32
        }
        
        struct DescriptionTitle {
            static let marginTop: CGFloat = 18
            static let marginHorizontal: CGFloat = 16
            
            static let text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur feugiat nisi ac erat porttitor pretium. Integer nec ullamcorper ex, id pellentesque leo. Proin tempus dolor nec nibh pulvinar, vitae tempor turpis placerat. Fusce interdum ornare metus a suscipit. Proin tincidunt bibendum nisi, non tempor tellus hendrerit et. Sed molestie sapien at nulla ornare iaculis. In faucibus tellus in consectetur iaculis."
        }
        
        struct EditButton {
            static let cornerRadius: CGFloat = 8
            static let height: CGFloat = 42
            static let marginHorizontal: CGFloat = 32
            static let marginBottom: CGFloat = 10
        }
    }
}
