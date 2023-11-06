//
//  SignUpVC.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 01/11/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class SignUpVC: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let upperView = UIView()
    let lowerView = UIView()
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
        view.backgroundColor = UIColor(named: "BackgroundColor")
        emailTextField.delegate = self
        passwordTextField1.delegate = self
        passwordTextField2.delegate = self
        passwordErrorLabel.isHidden = true
        configureUI()
        disableNextButton()
    }
    @objc func nextButtonPressed(){
        Auth.auth().createUser(withEmail: email, password: password1) { authResult, error in
            if let e = error{
                let alert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                self.navigationController?.pushViewController(HomeVC(), animated: true)
            }
        }
        
        
        
    }
    @objc func emailDidChange(_ textField: UITextField) {
        email = emailTextField.text
        
        if email == ""{
            disableNextButton()
        }
        else if email != nil && password1 != nil && password2 != nil{
            enableNextButton()
        }
    }
    @objc func password1DidChange(_ texField: UITextField){
        password1 = passwordTextField1.text
        if password1 == password2 && email != "" && password1 != "" && password2 != ""{
            passwordErrorLabel.isHidden = true
            enableNextButton()
        }
        else{
            passwordErrorLabel.isHidden = false
            disableNextButton()
        }
    }
    @objc func password2DidChange(_ texField: UITextField){
        password2 = passwordTextField2.text
        if password1 == password2 && email != "" && password1 != "" && password2 != ""{
            passwordErrorLabel.isHidden = true
            enableNextButton()
        }
        else{
            passwordErrorLabel.isHidden = false
            disableNextButton()
        }
    }
    
    func enableNextButton(){
        nextButton.isEnabled = true
        nextButton.layer.opacity = 1.0
    }
    func disableNextButton(){
        nextButton.isEnabled = false
        nextButton.layer.opacity = 0.5
    }
    func configureUI(){
        configureScrollView()
        configureStackView()
        configureUpperView()
        configureLowerView()
        
        configureSignUpLabel()
        configureEmailTextField()
        
        configurePasswordTextField1()
        configurePasswordError()
        configurePasswordTextField2()
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
    
    
    
    func configureSignUpLabel(){
        upperView.addSubview(signUpLabel)
        signUpLabel.text = "Sign Up"
        signUpLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        signUpLabel.textColor = .label
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpLabel.centerXAnchor.constraint(equalTo: upperView.centerXAnchor),
            signUpLabel.topAnchor.constraint(equalTo: upperView.topAnchor, constant: 100),
            
        ])
    }
    func configureEmailTextField(){
        upperView.addSubview(emailTextField)
        emailTextField.tag = 1
        emailTextField.addTarget(self, action: #selector(self.emailDidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 50),
            emailTextField.bottomAnchor.constraint(equalTo: upperView.bottomAnchor, constant: -15),
            emailTextField.leadingAnchor.constraint(equalTo: upperView.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: upperView.trailingAnchor, constant: -50)
        ])
    }
    func configurePasswordTextField1(){
        lowerView.addSubview(passwordTextField1)
        passwordTextField1.tag = 2
        passwordTextField1.addTarget(self, action: #selector(self.password1DidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            passwordTextField1.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 15),
            passwordTextField1.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 50),
            passwordTextField1.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -50)
        ])
    }
    func configurePasswordError(){
        lowerView.addSubview(passwordErrorLabel)
        
        passwordErrorLabel.text = "Two passwords do not match!"
        passwordErrorLabel.textColor = .red
        passwordErrorLabel.font = .systemFont(ofSize: 13, weight: .regular)
        passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordTextField1.leadingAnchor),
            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField1.bottomAnchor, constant: 10),
            
        ])
    }
    func configurePasswordTextField2(){
        lowerView.addSubview(passwordTextField2)
        passwordTextField2.tag = 3
        passwordTextField2.addTarget(self, action: #selector(self.password2DidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            passwordTextField2.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 5),
            passwordTextField2.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 50),
            passwordTextField2.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -50)
        ])
    }
    
    func configureNextButton(){
        lowerView.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: passwordTextField2.bottomAnchor, constant: 50),
            nextButton.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -100),
            nextButton.centerXAnchor.constraint(equalTo: lowerView.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 115),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}
extension SignUpVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            nextButtonPressed()
        }
        return false
    }
}
