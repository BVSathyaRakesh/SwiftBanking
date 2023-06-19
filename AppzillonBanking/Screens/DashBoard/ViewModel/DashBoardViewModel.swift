//
//  DashBoardViewModel.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/16.
//

import Foundation
import CoreData


class DashBoardViewModel {
    
    var userDetails = [UserDetails]()

    private var dashBoardService: DashBoardServiceProtocol

    init(dashboardservice: DashBoardServiceProtocol = DashBoardService()) {
        self.dashBoardService = dashboardservice
    }
    
    func getUserDetails(completion: @escaping ([String: AnyObject]?,Bool) -> ()) {
        dashBoardService.getUserDetails { [self] success, results, error in
            if success, let userDetails = results  {
                let dict = userDetails.apiResponse.responseBody.responseObj.toJSON() as? [String:AnyObject] // can be any type here
                CoreDataStorage.shared.clearStorage(forEntity: "Accounts")
                saveAccountDetails(userDetails: dict!)
                completion(dict,true)
            }else {
                completion(nil,false)
                print("error is \(String(describing: error))")
            }
        }
    }
    
    func saveAccountDetails(userDetails:[String:AnyObject]){
        let managedObjectContext = CoreDataStorage.shared.managedObjectContext()
        guard let accountEntity = NSEntityDescription.entity(forEntityName: "Accounts", in: managedObjectContext) else { return }
        //print(userDetails)
        if let name = userDetails["accountDetails"] {
            let userDetailsArray = name  as! [AnyObject]
            print(userDetailsArray[0]["customerName"] as Any)
            for i in 1...userDetailsArray.count-1 {
                let user =  NSManagedObject(entity: accountEntity, insertInto: managedObjectContext)
                user.setValue(UUID().uuidString, forKey: "id")
                user.setValue(userDetailsArray[i]["customerName"] as? String, forKey: "customerName")
                user.setValue(userDetailsArray[i]["accountNo"] as? String, forKey: "accountNo")
                user.setValue(userDetailsArray[i]["accountType"] as? String, forKey: "accountType")
                user.setValue(userDetailsArray[i]["availBalanceFcy"] as? String, forKey: "availBalanceFcy")
            }
        }
        
        do {
            try managedObjectContext.save()
            debugPrint("Data saved")
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
  
    
    
}


