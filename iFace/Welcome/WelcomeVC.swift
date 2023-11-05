//
//  WelcomeVC.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 01/11/23.
//

import UIKit

class WelcomeVC: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let upperView = UIView()
    let lowerView = UIView()
    let logoImageView = UIImageView()
    let signUpButton = CButton(title: "Sign Up")
    let logInButton = CButton(title: "Log In")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "ButtonColor")!]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        title = "Home"
        configureUI()
    }
    @objc func showSignUpView(){
        navigationController?.pushViewController(SignUpVC(), animated: true)
    }
    @objc func showLogInView(){
        navigationController?.pushViewController(LogInVC(), animated: true)
    }
    func configureUI(){
        configureScrollView()
        configureStackView()
        configureUpperView()
        configureLowerView()
        configureLogo()
        configureSignUpButton()
        configureLogInButton()
    }
    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    func configureStackView(){
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    func configureUpperView(){
        stackView.addArrangedSubview(upperView)
        upperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            upperView.topAnchor.constraint(equalTo: stackView.topAnchor),
            upperView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            upperView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
        ])
    }
    func configureLowerView(){
        stackView.addArrangedSubview(lowerView)
        upperView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowerView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            lowerView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lowerView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
        ])
    }
    func configureLogo(){
        upperView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "Logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: upperView.topAnchor, constant: 50),
            logoImageView.bottomAnchor.constraint(equalTo: upperView.bottomAnchor, constant: -50),
            logoImageView.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
            

            
        ])
        
    }
    
    func configureSignUpButton(){
        lowerView.addSubview(signUpButton)
        signUpButton.addTarget(self, action: #selector(showSignUpView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            signUpButton.widthAnchor.constraint(equalToConstant: 115),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 50),
            signUpButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -50),
            signUpButton.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 50)
            
        ])
    }
    func configureLogInButton(){
        lowerView.addSubview(logInButton)
        logInButton.addTarget(self, action: #selector(showLogInView), for: .touchUpInside)
        NSLayoutConstraint.activate([
            logInButton.widthAnchor.constraint(equalToConstant: 115),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 50),
            logInButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -50),
            logInButton.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -50)
            
        ])
    }
    

}
