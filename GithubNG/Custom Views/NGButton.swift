//
//  NGButton.swift
//  GithubNG
//
//  Created by Mac on 4.12.2022.
//

import UIKit

class NGButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 8
        titleLabel?.textColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 18)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
