//
//  File.swift
//  LoveBirds
//
//  Created by Shashwat Panda on 23/10/23.
//

import Foundation
import CoreData
import UIKit

struct CRUD {
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    //Save Core Data
    func saveName(entitySelected:String, name:String){
        guard let appDelegate = UIApplication.shared.delegate as?
                  AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entitySelected, in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        if(entitySelected == "RName"){
            newUser.setValue(name, forKey: "receiverName")
        }else{
            newUser.setValue(name, forKey: "senderName")
        }
        do{
            try context.save()
        }catch let error as NSError{
            print("error==",error)
        }
    }
    
    //Fetch Core Data
    func fetchName(entitySelected:String, key:String)->String{
        let context = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entitySelected)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let receiverName = data.value(forKey: key) as! String
                return receiverName
            }
        }catch let error as NSError{
            print("error==",error)
        }
        return "NA"
    }
    
    //Delete Core Data
    func deleteName(entitySelected:String){
        let context = appDelegate!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entitySelected)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                context.delete(data)
            }
            try context.save()
        }catch let error as NSError{
            print("error==",error)
        }
    }
}
