//
//  TransferItem.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 26.07.21.
//

import UIKit
import Firebase

struct TransferItem {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let amount: String
    let time: String
    let recieverId: String
    let senderId: String
    var completed: Bool
    
    init(name: String, completed: Bool, key: String = "", amount: String, time: String, recieverId: String, senderId: String) {
        self.ref = nil
        self.key = key
        self.name = name
        self.completed = completed
        self.amount = amount
        self.time = time
        self.recieverId = recieverId
        self.senderId = senderId
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let amount = value["amount"] as? String,
            let time = value["time"] as? String,
            let recieverId = value["recieverId"] as? String,
            let senderId = value["senderId"] as? String,
            let completed = value["completed"] as? Bool else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.amount = amount
        self.time = time
        self.completed = completed
        self.recieverId = recieverId
        self.senderId = senderId
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "amount": amount,
            "time": time,
            "recieverId": recieverId,
            "senderId": senderId,
            "completed": completed
        ]
    }
}

