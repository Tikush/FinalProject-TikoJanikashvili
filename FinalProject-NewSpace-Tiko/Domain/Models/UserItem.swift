//
//  UserItem.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 28.07.21.
//

import UIKit
import Firebase

struct UserItem {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let amount: String
    let email: String
    var completed: Bool
    
    init(name: String, key: String = "", amount: String, email: String, completed: Bool) {
        self.ref = nil
        self.key = key
        self.name = name
        self.amount = amount
        self.email = email
        self.completed = completed
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let amount = value["amount"] as? String,
            let email = value["email"] as? String,
            let completed = value["completed"] as? Bool else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.amount = amount
        self.email = email
        self.completed = completed
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "amount": amount,
            "email": email,
            "completed": completed
        ]
    }
}
