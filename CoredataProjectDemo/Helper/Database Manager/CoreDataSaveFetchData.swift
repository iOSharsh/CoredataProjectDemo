//
//  CoreDataSaveFetchData.swift
//  CoredataProjectDemo
//
//  Created by mac on 27/01/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataSaveFetchData
{
    static var sharedInstant = CoreDataSaveFetchData()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func saveInDatabase(object:[String:Any])
    {
        let user = NSEntityDescription.insertNewObject(forEntityName: "EmployeDetails", into: context!) as! EmployeDetails
        user.name = object["name"] as? String
        user.mobilenumber = object["mobilenumber"] as? String
        user.profile = object["profile"] as? Data
       
        do {
            try context?.save()
        } catch
        {
            print("Data is Not Save")
        }
    }
    func fetchData() -> [EmployeDetails]
    {
        var employeDetails = [EmployeDetails]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EmployeDetails")
      
        do {
            employeDetails = try context?.fetch(fetchRequest) as! [EmployeDetails]
            
        } catch  {
            print("error in Fetching... Data")
        }
        return employeDetails
    }
    
    func deleteData(index:Int) -> [EmployeDetails]
    {
        var employe = fetchData()
        context?.delete(employe[index])
        employe.remove(at: index)
        do {
            try context?.save()
        } catch  {
            print("Cannot Delete Data")
        }
        return employe
    }
    func editData(object:[String:Any],i:Int)
    {
        var employe = fetchData()
        employe[i].name = object["name"] as! String
        employe[i].mobilenumber = object["mobilenumber"] as! String
        employe[i].profile = object["profile"] as? Data
       
        do {
            try context?.save()
        } catch
        {
            print("Data is Update  Save")
        }
    }
}
