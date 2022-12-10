//
//  SearchViewController.swift
//  GithubNG
//
//  Created by Mac on 3.12.2022.
//

import UIKit

class SearchViewController: UIViewController {

    let logoIV = UIImageView()
    let usernameTextField = NGTextField()
    let callToActionButton = NGButton(backgroundColor: UIColor(patternImage: UIImage(named: "purpleGradient")!), title: "Get your followers")
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        
        view.backgroundColor = .black
        configureLogoIV()
        configureTextField()
        configureCallToActionButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
   
    
    func configureLogoIV() {
        view.addSubview(logoIV)
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.image = UIImage(named: "logo")
        logoIV.tintColor = .white
        logoIV.layer.cornerRadius = 2
        logoIV.layer.shadowColor = UIColor(named: "purpleMain")?.cgColor
        logoIV.layer.shadowOffset = CGSizeMake(0, 0)
        logoIV.layer.shadowOpacity = 0.5

        
        NSLayoutConstraint.activate([
            logoIV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoIV.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logoIV.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3.8),
            logoIV.widthAnchor.constraint(equalToConstant: 240)
        ])
    }

    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 42),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            usernameTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushToFollowersListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            callToActionButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func dissmisKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
   @objc func pushToFollowersListVC() {
       guard isUsernameEntered else { return
              presentNGAlertOnMainThread(title: "Empty Username", message: "Please enter a username to reach accounts.", buttonTitle: "I got it.")
               }
        let followersListVC = FollowersListViewController()
       followersListVC.username = usernameTextField.text
       followersListVC.title = usernameTextField.text
       navigationController?.pushViewController(followersListVC, animated: true)
    }

}



extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowersListVC()
        return true
    }
}
