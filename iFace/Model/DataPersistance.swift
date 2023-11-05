//
//  DataPersistance.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 03/11/23.
//

import Foundation
import CoreData
import UIKit
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let conversationFetchRequest: NSFetchRequest<ConversationModelEntity> = ConversationModelEntity.fetchRequest()
    
func saveData(){
    do{
        try context.save()
    }
    catch{
        print(error.localizedDescription)
    }
}
func addData(text:String,isUser:Bool,id:String? = nil,host:String? = nil){
    let conversation = ConversationModelEntity(context: context)
    conversation.text = text
    conversation.isUser = isUser
    conversation.host = host
    conversation.id = id
    saveData()
}
