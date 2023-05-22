//
//  History + CoreDataProperties.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 22.05.2023.
//

import Foundation
import CoreData


extension History {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        
        return NSFetchRequest<History>(entityName: "Recent")
    }
    
    @NSManaged public var language: String
    @NSManaged public var type: String
    @NSManaged public var text: String
    
}
