//
//  FavoritesTableViewCell.swift
//  GithubNG
//
//  Created by Mac on 11.12.2022.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "favoriteCell"
    
    let profileImageView = NGProfileImageView(frame: .zero)
    let usernameLabel = NGTitleLabel(textAlignment: .center, fontSize: 14)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower) {
        usernameLabel.text = favorite.login
        profileImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(profileImageView)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
