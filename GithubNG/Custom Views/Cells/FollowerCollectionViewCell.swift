//
//  FollowerCollectionViewCell.swift
//  GithubNG
//
//  Created by Mac on 5.12.2022.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "followerCell"
    
    let profileImageView = NGProfileImageView(frame: .zero)
    let usernameLabel = NGTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        profileImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            profileImageView.heightAnchor.constraint(equalToConstant: 108),
            profileImageView.widthAnchor.constraint(equalToConstant: 108),
            
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            usernameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
}
