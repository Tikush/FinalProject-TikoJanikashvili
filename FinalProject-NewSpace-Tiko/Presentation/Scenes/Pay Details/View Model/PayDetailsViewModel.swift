//
//  PayDetailsViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 21.07.21.
//

import Foundation
import Firebase

protocol PayDetailsViewModelProtocol: AnyObject {
    func addPayment(with currenrUser: User, refKey: String, paymentItem: PaymentItem)
    func fetchAmountByUser(with currenrUser: User, refKey: String, amount: String, complition: @escaping(UserItem) -> Void)
    func updateUser(with currenrUser: User, refKey: String, amount: String)
    
    var controller: CoordinatorDelegate { get }
    init(with controller: CoordinatorDelegate)
}

final class PayDetailsViewModel: PayDetailsViewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    
    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
    
    func addPayment(with currenrUser: User, refKey: String, paymentItem: PaymentItem) {
        let ref = Database.database().reference(withPath: refKey)
        let paymentItems = PaymentItem(name: paymentItem.name,
                                       addedByUser: currenrUser.email,
                                       completed: false,
                                       amount: paymentItem.amount,
                                       time: paymentItem.time)
        let paymentItemRef = ref.child(paymentItem.name.lowercased())
        
        paymentItemRef.setValue(paymentItems.toAnyObject())
    }
    
    func fetchAmountByUser(with currenrUser: User, refKey: String, amount: String, complition: @escaping(UserItem) -> Void) {
        let refUser = Database.database().reference(withPath: refKey)
        refUser.queryOrdered(byChild: "email").observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let userItem = UserItem(snapshot: snapshot) {
                    if currenrUser.email == userItem.email {
                        complition(userItem)
                    }
                }
            }
        })
    }
    
    func updateUser(with currenrUser: User, refKey: String, amount: String) {
        let refUser = Database.database().reference(withPath: refKey)
        fetchAmountByUser(with: currenrUser, refKey: refKey, amount: amount) { userItem in
            let updateAmount = (Int(userItem.amount) ?? 0) - (Int(amount) ?? 0)
            refUser.child(userItem.name).updateChildValues( [
                "amount": updateAmount
            ])
        }
    }
}
