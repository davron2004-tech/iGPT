//
//  SignUpVC.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 01/11/23.
//

import UIKit

class LogInVC: UIViewController,UITextFieldDelegate {
    let emailTextField = CTextField(placeHolder: "Email")
    let passwordTextField = CTextField(placeHolder: "Password")
    let signUpLabel = UILabel()
    let nextButton = CButton(title: "Next")
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        view.backgroundColor = UIColor(named: "BackgroundColor")
        configureUI()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        
    }
    @objc func nextButtonTapped(){
        
    }
    func configureUI(){
        configureSignUpLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureNextButton()
    }
    func configureEmailTextField(){
        view.addSubview(emailTextField)
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    func configurePasswordTextField(){
        view.addSubview(passwordTextField)
        passwordTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    func configureSignUpLabel(){
        view.addSubview(signUpLabel)
        signUpLabel.text = "Log In"
        signUpLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        signUpLabel.textColor = .label
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpLabel.centerYAnchor.constraint(equalTo: view.topAnchor,constant: 200)
        ])
    }
    func configureNextButton(){
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 100),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 115),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

}
