//
//  TopMoneyViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 28.07.21.
//

import Foundation
import Firebase

protocol TopMoneyViewModelProtocol: AnyObject {
    func fetchAmountByUser(with currentUser: User, refKey: String, complition: @escaping(String) -> Void)
}

class TopMoneyViewModel: TopMoneyViewModelProtocol {
    
    func fetchAmountByUser(with currentUser: User, refKey: String, complition: @escaping (String) -> Void) {
        let refUser = Database.database().reference(withPath: refKey)
 
        refUser.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                       let userItem = UserItem(snapshot: snapshot) {
                        if currentUser.email == userItem.email {
                            complition(userItem.amount)
                        }
                    }
                }
        })
    }
}
