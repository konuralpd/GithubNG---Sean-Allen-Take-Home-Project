//
//  NGFollowersItemViewController.swift
//  GithubNG
//
//  Created by Mac on 10.12.2022.
//

import UIKit


class NGFollowersItemViewController: NGItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configreItems()
    }
    
    private func configreItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Followers")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
