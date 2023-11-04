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
var conversationEntity:NSEntityDescription{
    return NSEntityDescription.entity(
        forEntityName: "ConversationModelEntity",
        in: context
    )!
}
let conversationFetchRequest = NSFetchRequest<NSFetchRequestResult>(
    entityName: "ConversationModelEntity"
)
func saveData(){
    do{
        try context.save()
    }
    catch{
        print(error.localizedDescription)
    }
}
func addData(text:String,isUser:Bool,id:String = "",host:String = ""){
    let conversation = NSManagedObject(entity: conversationEntity, insertInto: context)
    conversation.setValue(text, forKey: "text")
    conversation.setValue(isUser, forKey: "isUser")
    conversation.setValue(host, forKey: "host")
    conversation.setValue(id, forKey: "id")
    saveData()
}
