//
//  UIViewController+Extensions.swift
//  GithubNG
//
//  Created by Mac on 4.12.2022.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
  func presentNGAlertOnMainThread(title: String, message: String, buttonTitle: String) {
      DispatchQueue.main.async {
          let alertVC = NGAlertViewController(alertTitle: title, message: message, buttonTitle: buttonTitle)
          alertVC.modalPresentationStyle = .overFullScreen
          alertVC.modalTransitionStyle = .crossDissolve
          self.present(alertVC, animated: true)
      }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .black
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tintColor = .systemPurple
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dissmissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showNoUserFoundView(with message: String, in view: UIView) {
        let noUserView = NGNoUserView(message: message)
        noUserView.frame = view.bounds
        view.addSubview(noUserView)
    }
}
