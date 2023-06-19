//
//  TransferViewModel.swift
//  AppzillonBanking
//
//  Created by Rakesh BVS. Kumar on 2022/12/31.
//

import Foundation
import CoreData


class TransferViewModel {
    
    
    private var transferService: TransferServiceProtocol

    init(transferservice: TransferServiceProtocol = TransferService()) {
        self.transferService = transferservice
    }
    
    func getBeneficiariesData(completion: @escaping ([BeneficiariesData]?,Bool) -> ()){
        transferService.getBeneficiaryDetails { success, results, error in
            if success, let userDetails = results  {
                let data = Data(userDetails.apiResponse.responseBody.responseObj.utf8)
                do {
                    let model = try JSONDecoder().decode([BeneficiariesData].self, from: data)
                    //print(model)
                    completion(model,true)
                } catch {
                    completion(nil,true)
                }
                
            }else {
                completion(nil,false)
                print("error is \(String(describing: error))")
            }
        }
    }
    
    
    
    func fetchAccountsData() {
        let managedObjectContext = CoreDataStorage.shared.managedObjectContext()
        let  fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Accounts")
             fetchRequest.predicate = NSPredicate(format: "accountType = %@", "SB")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "username", ascending: true)]
        do {
            
            guard let result = try managedObjectContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return
            }
            debugPrint(result)
//            for data in result {
//                debugPrint(data.value(forKey: "customerName") as? String ?? "")
//                debugPrint(data.value(forKey: "accountNo") as? String ?? "")
//                debugPrint(data.value(forKey: "accountType") as? String ?? "")
//                debugPrint(data.value(forKey: "availBalanceFcy") as? String ?? "")
//            }
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
}


