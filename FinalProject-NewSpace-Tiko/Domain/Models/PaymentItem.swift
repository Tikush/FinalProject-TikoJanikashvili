//
//  GloceryItem.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 26.07.21.
//

import UIKit
import Firebase

struct PaymentItem {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let addedByUser: String
    let amount: String
    let time: String
    var completed: Bool
    
    init(name: String, addedByUser: String, completed: Bool, key: String = "", amount: String, time: String) {
        self.ref = nil
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.completed = completed
        self.amount = amount
        self.time = time
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let addedByUser = value["addedByUser"] as? String,
            let amount = value["amount"] as? String,
            let time = value["time"] as? String,
            let completed = value["completed"] as? Bool else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.addedByUser = addedByUser
        self.amount = amount
        self.time = time
        self.completed = completed
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "amount": amount,
            "time": time,
            "completed": completed
        ]
    }
}
