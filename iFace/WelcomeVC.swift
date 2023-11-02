//
//  WelcomeVC.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 01/11/23.
//

import UIKit

class WelcomeVC: UIViewController {
    
    let logoImageView = UIImageView()
    let signUpButton = CButton(title: "Sign Up")
    let logInButton = CButton(title: "Log In")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        configureUI()
    }
    @objc func showSignUpView(){
        navigationController?.pushViewController(SignUpVC(), animated: true)
    }
    @objc func showLogInView(){
        navigationController?.pushViewController(LogInVC(), animated: true)
    }
    func configureUI(){
        configureLogo()
        configureSignUpButton()
        configureLogInButton()
    }
    func configureLogo(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "Logo")
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100)
            
        ])
        
    }
    
    func configureSignUpButton(){
        view.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(showSignUpView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            signUpButton.widthAnchor.constraint(equalToConstant: 115),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
            
        ])
    }
    func configureLogInButton(){
        view.addSubview(logInButton)
        logInButton.addTarget(self, action: #selector(showLogInView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            logInButton.widthAnchor.constraint(equalToConstant: 115),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
            
        ])
    }
    

}
