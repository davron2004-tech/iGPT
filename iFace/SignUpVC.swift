//
//  SignUpVC.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 01/11/23.
//

import UIKit

class SignUpVC: UIViewController,UITextFieldDelegate {
    let emailTextField = CTextField(placeHolder: "Email")
    let passwordTextField1 = CTextField(placeHolder: "Password")
    let passwordTextField2 = CTextField(placeHolder: "Repeat the password")
    let signUpLabel = UILabel()
    let passwordErrorLabel = UILabel()
    let nextButton = CButton(title: "Next")
    var email:String!
    var password1:String!
    var password2:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField1.delegate = self
        passwordTextField2.delegate = self
        passwordErrorLabel.isHidden = true
        view.backgroundColor = UIColor(named: "BackgroundColor")
        configureUI()
    }
    @objc func emailDidChange(_ textField: UITextField) {
        email = emailTextField.text
    }
    @objc func password1DidChange(_ texField: UITextField){
        password1 = passwordTextField1.text
        if password1 == password2{
            passwordErrorLabel.isHidden = true
        }
        else{
            passwordErrorLabel.isHidden = false
        }
    }
    @objc func password2DidChange(_ texField: UITextField){
        password2 = passwordTextField2.text
        if password1 == password2{
            passwordErrorLabel.isHidden = true
        }
        else{
            passwordErrorLabel.isHidden = false
        }
    }
    @objc func nextButtonTapped(){
        
    }
    func configureUI(){
        configureSignUpLabel()
        configureEmailTextField()
        configurePasswordTextField1()
        configurePasswordTextField2()
        configurePasswordError()
        configureNextButton()
    }
    func configureSignUpLabel(){
        view.addSubview(signUpLabel)
        signUpLabel.text = "Sign Up"
        signUpLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        signUpLabel.textColor = .label
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpLabel.centerYAnchor.constraint(equalTo: view.topAnchor,constant: 200)
        ])
    }
    func configureEmailTextField(){
        view.addSubview(emailTextField)
        emailTextField.addTarget(self, action: #selector(self.emailDidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    func configurePasswordTextField1(){
        view.addSubview(passwordTextField1)
        passwordTextField1.addTarget(self, action: #selector(self.password1DidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            passwordTextField1.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    func configurePasswordError(){
        view.addSubview(passwordErrorLabel)
        
        passwordErrorLabel.text = "Two passwords do not match!"
        passwordErrorLabel.textColor = .red
        passwordErrorLabel.font = .systemFont(ofSize: 13, weight: .regular)
        passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordTextField1.leadingAnchor),
            passwordErrorLabel.bottomAnchor.constraint(equalTo: passwordTextField2.topAnchor, constant: -5)
        ])
    }
    func configurePasswordTextField2(){
        view.addSubview(passwordTextField2)
        passwordTextField2.addTarget(self, action: #selector(self.password2DidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            passwordTextField2.topAnchor.constraint(equalTo: passwordTextField1.bottomAnchor, constant: 30),
            passwordTextField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    func configureNextButton(){
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: passwordTextField2.bottomAnchor, constant: 100),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 115),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

}
