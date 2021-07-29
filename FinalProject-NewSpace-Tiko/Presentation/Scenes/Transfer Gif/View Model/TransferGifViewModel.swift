//
//  TransferGifViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 23.07.21.
//

import Foundation
import Firebase

protocol TransferGifViewModelProtocol: AnyObject {
    func transferMoney(with currenrUser: User, refKey: String, transferItem: TransferItem)
    var controller: CoordinatorDelegate { get }
    
    init(with controller: CoordinatorDelegate)
}

final class TransferGifViewModel: TransferGifViewModelProtocol {
    
    private(set) var controller: CoordinatorDelegate
    
    init(with controller: CoordinatorDelegate) {
        self.controller = controller
    }
    
    func transferMoney(with currenrUser: User, refKey: String, transferItem: TransferItem) {
        let ref = Database.database().reference(withPath: refKey)

        let transferItems = TransferItem(name: transferItem.name,
                                         completed: transferItem.completed,
                                         amount: transferItem.amount,
                                         time: transferItem.time,
                                         recieverId: transferItem.recieverId, senderId: transferItem.senderId)
        let transferItemRef = ref.child(transferItem.name.lowercased())

        transferItemRef.setValue(transferItems.toAnyObject())
    }
}
