//
//  DataPersistance.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 03/11/23.
//

import Foundation
import CoreData
import UIKit
struct DataPersistanceModel{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let conversationFetchRequest: NSFetchRequest<ConversationModelEntity> = ConversationModelEntity.fetchRequest()
    var delegate:HomeVC!
    func retrieveData(){
        do{
            let result = try context.fetch(conversationFetchRequest)
            delegate.conversationList = result
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func saveData(){
        do{
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}
