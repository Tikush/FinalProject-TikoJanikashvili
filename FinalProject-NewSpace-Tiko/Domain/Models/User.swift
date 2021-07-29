//
//  User.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 26.07.21.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    let phone: String
    
    init(authData: Firebase.User) {
        uid = authData.uid
        email = authData.email!
        phone = authData.phoneNumber!
    }
    
    init(uid: String, email: String, phone: String) {
        self.uid = uid
        self.email = email
        self.phone = phone
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let uid = value["uid"] as? String,
            let email = value["email"] as? String,
            let phone = value["phone"] as? String else {
            return nil
        }
        
        self.uid = uid
        self.email = email
        self.phone = phone
    }
}
