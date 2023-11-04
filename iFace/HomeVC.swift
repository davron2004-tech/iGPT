//
//  HomeVC.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 02/11/23.
//

import UIKit
import CoreData
class HomeVC: UIViewController,UITextFieldDelegate {
    var safeArea: UILayoutGuide!
    let conversationTV = UITableView()
    let sendButton = UIButton()
    let textBar = CTextField(placeHolder: "Text")
    var conversationList:[ConversationModel] = []
    var text = ""
    var wolfram = WolframAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveData()
        view.backgroundColor = .systemBackground
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "ButtonColor")!]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        title = "Chat"
        safeArea = view.layoutMarginsGuide
        wolfram.delegate = self
        conversationTV.delegate = self
        conversationTV.dataSource = self
        textBar.delegate = self
        configureConversationTV()
        configureSendButton()
        configureTextBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func retrieveData(){
        do{
            let result = try context.fetch(conversationFetchRequest)
            for data in result as! [NSManagedObject]{
                conversationList.append(ConversationModel(
                    isUser: data.value(forKey: "isUser") as! Bool,
                    result: data.value(forKey: "text") as! String,
                    conversationID: data.value(forKey: "id") as! String,
                    host: data.value(forKey: "host") as! String)
                )
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    @objc func textDidChange(_ textField: UITextField) {
        text = textField.text ?? ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fetchResult()
        return false
    }
    @objc func fetchResult(){
        textBar.text = ""
        view.endEditing(true)
        conversationList.append(ConversationModel(isUser: true, result: text,conversationID: "",host: ""))
        conversationTV.reloadData()
        DispatchQueue.main.async {
            self.conversationTV.scrollToRow(at: IndexPath(row: self.conversationList.count - 1, section: 0), at: .bottom, animated: true)
        }
        addData(text: text, isUser: true)
        var lastElement:ConversationModel?{
            for element in conversationList.reversed(){
                if element.host != ""{
                    return element
                }
            }
            return nil
            
        }
        let encodedString = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!.lowercased().replacingOccurrences(of: "%20", with: "+")
        wolfram.text = encodedString
        if let element = lastElement{
            wolfram.getAnswer(id: element.conversationID,host: element.host)
        }else{
            wolfram.getAnswer()
        }
        
    }
    func addResult(model:ConversationModel){
        conversationList.append(model)
        DispatchQueue.main.async {
            self.conversationTV.reloadData()
        }
        DispatchQueue.main.async {
            self.conversationTV.scrollToRow(at: IndexPath(row: self.conversationList.count - 1, section: 0), at: .bottom, animated: true)
        }
        
    }
    func configureConversationTV(){
        view.addSubview(conversationTV)
        conversationTV.separatorStyle = .none
        conversationTV.register(GreenBubble.self, forCellReuseIdentifier: "GreenCell")
        conversationTV.register(BlueBubble.self, forCellReuseIdentifier: "BlueCell")
        conversationTV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conversationTV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conversationTV.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            conversationTV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
            
        ])
    }
    func configureTextBar(){
        view.addSubview(textBar)
        
        textBar.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        NSLayoutConstraint.activate([
            textBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            textBar.topAnchor.constraint(equalTo: conversationTV.bottomAnchor, constant: 20),
            textBar.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            textBar.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor,constant: -10)
            
        ])
    }
    func configureSendButton(){
        view.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(fetchResult), for: .touchUpInside)
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            sendButton.trailingAnchor.constraint(equalTo: conversationTV.trailingAnchor),
            sendButton.topAnchor.constraint(equalTo: conversationTV.bottomAnchor, constant: 20),
        ])
        
    }
    
    
    
}
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = conversationList[indexPath.row]
        if element.isUser{
            let cell = conversationTV.dequeueReusableCell(withIdentifier: "BlueCell") as? BlueBubble
            cell?.selectionStyle = .none
            cell?.cellText.text = element.result
            return cell!
            
        }
        else{
            let cell = conversationTV.dequeueReusableCell(withIdentifier: "GreenCell") as? GreenBubble
            cell?.selectionStyle = .none
            cell?.cellText.text = element.result
            return cell!
        }
    }
    
    
}

struct ConversationModel{
    let isUser:Bool
    let result:String
    var conversationID:String
    var host:String
}
