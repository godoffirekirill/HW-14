//
//  SecondViewController.swift
//  HW-14
//
//  Created by Кирилл Курочкин on 14.06.2024.
//

import UIKit

import UIKit

class SecondViewController: UIViewController {
    
    let loginLabel = UILabel()
    let passwordLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Second"
        view.backgroundColor = .white
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginLabel)
        view.addSubview(passwordLabel)
        
        loginLabel.text = "Login: \(UserDefaultsManager.login ?? "")"
        passwordLabel.text = "Password: \(UserDefaultsManager.password ?? "")"
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            passwordLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
}

