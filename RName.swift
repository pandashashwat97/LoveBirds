//
//  ReceiverName+CoreDataClass.swift
//  
//
//  Created by Shashwat Panda on 19/10/23.
//
//

import Foundation
import CoreData


public class RName: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RName> {
        return NSFetchRequest<RName>(entityName: "RName")
    }

    @NSManaged public var receiverName: String?
}
