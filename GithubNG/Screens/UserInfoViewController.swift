//
//  UserInfoViewController.swift
//  GithubNG
//
//  Created by Mac on 9.12.2022.
//

import UIKit
import SafariServices

protocol UserInfoViewControllerDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoViewController: UIViewController {
    
    var username: String!
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    weak var delegate: FollowerListViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        layoutUI()
        getUserInfo()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
      
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: NGUserInfoHeaderViewController(user: user), to: self.headerView)
                    
                    let repoItemVC = NGRepoItemViewController(user: user)
                    repoItemVC.delegate = self
                    
                    let followerItemVC = NGFollowersItemViewController(user: user)
                    followerItemVC.delegate = self
                    
                    
                    self.add(childVC: NGRepoItemViewController(user: user), to: self.itemViewOne)
                    self.add(childVC: NGFollowersItemViewController(user: user), to: self.itemViewTwo)
                }
            case .failure(let error):
                self.presentNGAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func layoutUI() {
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
  
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140)
            
        ])
    }
    
  
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    


}

extension UserInfoViewController: UserInfoViewControllerDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else { presentNGAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "I got it.")
            return
            
        }
        
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .black
        present(safariVC, animated: true)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            return
        }
        delegate.didTapRequestFollowers(for: user.login)
        dismissVC()
    }
    
  

}
