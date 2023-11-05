//
//  WolframAPI.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 02/11/23.
//

import Foundation
import CoreData
import UIKit
struct WolframAPI{
    let apiKey = "L8LG9L-HP77QG26L8"
    var delegate:HomeVC?
    var text:String?
    func getAnswer(id:String? = nil,host:String? = nil){
        var url:String{
            if let safehHost = host, let safeId = id{
                return "https://\(safehHost)/api/v1/conversation.jsp?appid=\(apiKey)&conversationid=\(safeId)&i=\(text!)"
            }
            return "https://api.wolframalpha.com/v1/conversation.jsp?appid=\(apiKey)&i=\(text!)"
        }
        
        guard let url = URL(string: url) else {
            return
        }
        print(url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let e = error{
                print(e.localizedDescription)
            }
            else{
                if let safeData = data{
                    parseData(data: safeData)
                }
            }
        }
        task.resume()
    }
    func parseData(data:Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WolframDataModel.self, from: data)
            let model = ConversationModelEntity(context: context)
            model.text = decodedData.result
            model.isUser = false
            model.host = decodedData.host
            model.id = decodedData.conversationID
            delegate?.addResult(model: model)
        }
        catch{
            getAnswer()
        }
    }
}

struct WolframDataModel:Codable{
    let result:String
    let conversationID:String
    let host:String
}

