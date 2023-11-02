//
//  HomeVC.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 02/11/23.
//
//https://api.wolframalpha.com/v1/conversation.jsp?appid=L8LG9L-HP77QG26L8&i=how+much+does+the+earth+weigh%3f
//https://api.wolframalpha.com/v1/conversation.jsp?appid=L8LG9L-HP77QG26L8&i=How+much+does+the+earth+weigh%3f
//https://www6b3.wolframalpha.com/api/v1/conversation.jsp?appid=L8LG9L-HP77QG26L8&conversationid=MSP456519hd9db2bg74g6a700001a8bgi0d36a9g8e8&i=What+is+that+in+pounds%3f
import UIKit

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
        view.backgroundColor = .systemBackground
        safeArea = view.layoutMarginsGuide
        wolfram.delegate = self
        conversationTV.delegate = self
        conversationTV.dataSource = self
        textBar.delegate = self
        configureConversationTV()
        configureSendButton()
        configureTextBar()
        
        
    }
    @objc func textDidChange(_ textField: UITextField) {
        text = textField.text ?? ""
    }
    @objc func fetchResult(){
        textBar.text = ""
        let encodedString = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!.lowercased().replacingOccurrences(of: "%20", with: "+")
        let lastElement = conversationList.last
        conversationList.append(ConversationModel(isUser: true, result: text))
        conversationTV.reloadData()
        if let element = lastElement{
            if let host = element.host, let id = element.conversationID{
                wolfram.host = host
                wolfram.id = id
            }
        }
        wolfram.getAnswer(i: encodedString)
    }
    func addResult(model:ConversationModel){
        conversationList.append(model)
        DispatchQueue.main.async {
            self.conversationTV.reloadData()
        }
        
    }
    func configureConversationTV(){
        view.addSubview(conversationTV)
        conversationTV.separatorStyle = .none
        conversationTV.register(GreenBubble.self, forCellReuseIdentifier: "GreenCell")
        conversationTV.register(BlueBubble.self, forCellReuseIdentifier: "BlueCell")
        conversationTV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            conversationTV.topAnchor.constraint(equalTo: safeArea.topAnchor),
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
            cell?.cellText.text = element.result
            return cell!
            
        }
        else{
            let cell = conversationTV.dequeueReusableCell(withIdentifier: "GreenCell") as? GreenBubble
            cell?.cellText.text = element.result
            return cell!
        }
    }
    
    
}

struct ConversationModel{
    let isUser:Bool
    let result:String
    var conversationID:String?
    var host:String?
}
