//
//  TransactionViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 24.07.21.
//

import UIKit
import Firebase

protocol TransactionViewModelProtocol: AnyObject {
    func fetchPaymentWithUser(with currenrUser: User, refKey: String, complition: @escaping([PaymentItem]) -> Void)
    func fetchPhoneNumberByUser(with currenrUser: User, refKey: String, complition: @escaping(String) -> Void)
    func fetchTransferByPhone(with phone: String, refKey: String, complition: @escaping([TransferItem]) -> Void)
    func fetchTransferByEmail(with currenrUser: User, refKey: String, complition: @escaping([TransferItem]) -> Void)
    
    init(with navigationController: UINavigationController?, controller: CoordinatorDelegate)
    
    var controller: CoordinatorDelegate { get }
}

final class TransactionViewModel: TransactionViewModelProtocol {
    
    var controller: CoordinatorDelegate
    
    // MARK: - Private Properties
    private var navigationController: UINavigationController?
    
    init(with navigationController: UINavigationController?, controller: CoordinatorDelegate) {
        self.navigationController = navigationController
        self.controller = controller
    }
    
    func fetchPaymentWithUser(with currenrUser: User, refKey: String, complition: @escaping([PaymentItem]) -> Void) {
        let ref = Database.database().reference(withPath: refKey)
        ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
            var newItems: [PaymentItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let paymentItem = PaymentItem(snapshot: snapshot) {
                    if currenrUser.email == paymentItem.addedByUser {
                        newItems.append(paymentItem)
                    }
                }
            }
            complition(newItems)
        })
    }
    
    func fetchPhoneNumberByUser(with currenrUser: User, refKey: String, complition: @escaping(String) -> Void) {
        let refUser = Database.database().reference(withPath: refKey)
 
        refUser.queryOrdered(byChild: "email").observe(.value, with: { snapshot in
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                       let userItem = User(snapshot: snapshot) {
                        if currenrUser.email == userItem.email {
                            complition(userItem.phone)
                        }
                    }
                }
        })
    }
    
    func fetchTransferByPhone(with userPhone: String, refKey: String, complition: @escaping([TransferItem]) -> Void) {
        let ref = Database.database().reference(withPath: refKey)
        ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
            var newItems: [TransferItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let transferItem = TransferItem(snapshot: snapshot) {
                    if userPhone == transferItem.recieverId {
                        newItems.append(transferItem)
                    }
                }
            }
            complition(newItems)
        })
    }
    
    func fetchTransferByEmail(with currenrUser: User, refKey: String, complition: @escaping([TransferItem]) -> Void) {
        let ref = Database.database().reference(withPath: refKey)
        ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
            var newItems: [TransferItem] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let transferItem = TransferItem(snapshot: snapshot) {
                    if currenrUser.email == transferItem.senderId {
                        newItems.append(transferItem)
                    }
                }
            }
            complition(newItems)
        })
    }
}
