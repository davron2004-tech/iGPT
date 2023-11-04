//
//  SignUpVC.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 01/11/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class LogInVC: UIViewController,UITextFieldDelegate {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let upperView = UIView()
    let lowerView = UIView()
    let emailTextField = CTextField(placeHolder: "Email")
    let passwordTextField = CTextField(placeHolder: "Password")
    let logInLabel = UILabel()
    let nextButton = CButton(title: "Next")
    var email:String!
    var password:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        nextButton.layer.opacity = 0.5
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        configureUI()
    }
    @objc func nextButtonPressed(){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if authResult != nil{
                self?.navigationController?.pushViewController(HomeVC(), animated: true)
            }
            else{
                let alert = UIAlertController(title: "Error", message: "Wrong email or password!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    @objc func emailDidChange(_ textField: UITextField) {
        email = emailTextField.text
        if email == ""{
            nextButton.isEnabled = false
            nextButton.layer.opacity = 0.5
        }
        else if email != nil && password != nil{
            nextButton.isEnabled = true
            nextButton.layer.opacity = 1.0
        }
    }
    @objc func passwordDidChange(_ texField: UITextField){
        password = passwordTextField.text
        if email != "" && password != ""{
            nextButton.isEnabled = true
            nextButton.layer.opacity = 1.0
        }
        else{
            nextButton.isEnabled = false
            nextButton.layer.opacity = 0.5
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            nextButtonPressed()
        }
        return false
    }
    func configureUI(){
        configureScrollView()
        configureStackView()
        configureUpperView()
        configureLowerView()
        
        configureLogInLabel()
        configureEmailTextField()
        
        configurePasswordTextField()
        configureNextButton()
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
        lowerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lowerView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            lowerView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lowerView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
        ])
    }
    
    
    
    func configureLogInLabel(){
        upperView.addSubview(logInLabel)
        logInLabel.text = "Log In"
        logInLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        logInLabel.textColor = .label
        logInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logInLabel.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
            logInLabel.topAnchor.constraint(equalTo: upperView.topAnchor, constant: 100),
        ])
    }
    func configureEmailTextField(){
        upperView.addSubview(emailTextField)
        emailTextField.addTarget(self, action: #selector(emailDidChange), for: .editingChanged)
        emailTextField.tag = 1
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 50),
            emailTextField.bottomAnchor.constraint(equalTo: upperView.bottomAnchor, constant: -15),
            emailTextField.leadingAnchor.constraint(equalTo: upperView.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: upperView.trailingAnchor, constant: -50)
        ])
    }
    func configurePasswordTextField(){
        lowerView.addSubview(passwordTextField)
        passwordTextField.addTarget(self, action: #selector(passwordDidChange), for: .editingChanged)
        passwordTextField.tag = 2
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -50)
        ])
    }
    func configureNextButton(){
        lowerView.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            nextButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -100),
            nextButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 115),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}
