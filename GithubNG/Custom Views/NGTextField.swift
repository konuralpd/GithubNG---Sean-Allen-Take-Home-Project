//
//  NGTextField.swift
//  GithubNG
//
//  Created by Mac on 4.12.2022.
//

import UIKit

class NGTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor(patternImage: UIImage(named: "purpleGradient")!).cgColor
        layer.masksToBounds = true

        textColor = .white
        tintColor = .white
        textAlignment = .center
        font = .boldSystemFont(ofSize: 18)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        returnKeyType = .go
        
        autocorrectionType = .no
        placeholder = "Please Enter a Username"
        
    }
    

}
