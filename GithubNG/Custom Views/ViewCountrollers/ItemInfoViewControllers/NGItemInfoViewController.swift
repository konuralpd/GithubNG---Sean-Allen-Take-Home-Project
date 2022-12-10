//
//  NGItemInfoViewController.swift
//  GithubNG
//
//  Created by Mac on 10.12.2022.
//

import UIKit

class NGItemInfoViewController: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = NGItemInfoView()
    let itemInfoViewTwo = NGItemInfoView()
    let actionButton = NGButton()
    
    var user: User!
    weak var delegate: UserInfoViewControllerDelegate!
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureActionButton()
        
        
    }
    
    func configureBackgroundView() {
        view.layer.cornerRadius = 16
        view.backgroundColor = .white.withAlphaComponent(0.08)
    }
    
  private func layoutUI() {
      view.addSubview(stackView)
      view.addSubview(actionButton)
      stackView.axis = .horizontal
      stackView.distribution = .equalSpacing
      stackView.addArrangedSubview(itemInfoViewOne)
      stackView.addArrangedSubview(itemInfoViewTwo)
      stackView.translatesAutoresizingMaskIntoConstraints = false
      let padding: CGFloat = 20
      
      NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        stackView.heightAnchor.constraint(equalToConstant: 50),
        
        actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
        actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        actionButton.heightAnchor.constraint(equalToConstant: 46)
      ])
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    @objc func actionButtonTapped() {
       
    }

}
