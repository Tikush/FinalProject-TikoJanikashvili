//
//  RegisterViewModel.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 28.07.21.
//

import UIKit
import Firebase

protocol RegisterViewModelProtocol: AnyObject {
    func addUserDetails(with currenrUser: User, refKey: String, userItem: UserItem)
}

class RegisterViewModel: RegisterViewModelProtocol {
    
    func addUserDetails(with currenrUser: User, refKey: String, userItem: UserItem) {
        let ref = Database.database().reference(withPath: refKey)
        let userItems = UserItem(name: userItem.name, amount: userItem.amount, email: userItem.email, completed: false)
        let puserItemRef = ref.child(userItems.name.lowercased())
        puserItemRef.setValue(userItems.toAnyObject())
    }
}
