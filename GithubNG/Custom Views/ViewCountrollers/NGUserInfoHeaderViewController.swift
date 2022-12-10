//
//  NGUserInfoHeaderViewController.swift
//  GithubNG
//
//  Created by Mac on 9.12.2022.
//

import UIKit

class NGUserInfoHeaderViewController: UIViewController {
    
    let avatarImageView = NGProfileImageView(frame: .zero)
    let usernameLabel = NGTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = NGSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = NGSecondaryTitleLabel(fontSize: 18)
    let biolabel = NGBodyLabel(textAlignment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSubviews()
        layoutUI()
        configreUIElements()
    }

    func makeSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(biolabel)

    }
    
    func configreUIElements() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "N/A"
        biolabel.text = user.bio ?? "N/A"
        biolabel.numberOfLines = 3
        locationImageView.image = UIImage(systemName: "network")
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.tintColor = .systemIndigo
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
       
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: textImagePadding),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding)
        ])
        
        NSLayoutConstraint.activate([
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            biolabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            biolabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            biolabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            biolabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
