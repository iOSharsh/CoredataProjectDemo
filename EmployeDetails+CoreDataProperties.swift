//
//  EmployeDetails+CoreDataProperties.swift
//  CoredataProjectDemo
//
//  Created by mac on 28/01/21.
//
//

import Foundation
import CoreData


extension EmployeDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeDetails> {
        return NSFetchRequest<EmployeDetails>(entityName: "EmployeDetails")
    }

    @NSManaged public var mobilenumber: String?
    @NSManaged public var name: String?
    @NSManaged public var profile: Data?

}

extension EmployeDetails : Identifiable {

}
