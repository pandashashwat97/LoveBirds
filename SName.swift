//
//  ReceiverName+CoreDataProperties.swift
//  
//
//  Created by Shashwat Panda on 19/10/23.
//
//

import Foundation
import CoreData


public class SName: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SName> {
        return NSFetchRequest<SName>(entityName: "SName")
    }

    @NSManaged public var senderName: String?
}
