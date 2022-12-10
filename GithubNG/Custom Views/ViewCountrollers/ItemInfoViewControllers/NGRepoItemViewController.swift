//
//  NGRepoItemViewController.swift
//  GithubNG
//
//  Created by Mac on 10.12.2022.
//

import UIKit


class NGRepoItemViewController: NGItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configreItems()
    }
    
    private func configreItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemIndigo, title: "Github Profile")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
