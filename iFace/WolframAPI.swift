//
//  WolframAPI.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 02/11/23.
//

import Foundation
struct WolframAPI{
    let apiKey = "L8LG9L-HP77QG26L8"
    var delegate:HomeVC?
    var id:String?
    var host:String?
    func getAnswer(i:String){
        var url:String{
            if let safehHost = host, let safeId = id{
                return "https://\(safehHost)/api/v1/conversation.jsp?appid=\(apiKey)&conversationid=\(safeId)&i=\(i)"
            }
            return "https://api.wolframalpha.com/v1/conversation.jsp?appid=\(apiKey)&i=\(i)"
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
            var model = ConversationModel(isUser: false, result: decodedData.result)
            if let host = decodedData.host{
                model.host = host
            }
            if let id = decodedData.conversationID{
                model.conversationID = id
            }
            delegate?.addResult(model: model)
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
}

struct WolframDataModel:Codable{
    let result:String
    let conversationID:String?
    let host:String?
}

