//
//  AccountSettingView.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 26.07.21.
//

import UIKit
import FirebaseAuth
import Firebase

protocol MoveOtherScreenDelegate: AnyObject {
    func selectLogOut()
}

class AccountSettingView: UIView {
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var viewLine: UIView!
    @IBOutlet private weak var settingView: UIView!
    @IBOutlet private weak var helpView: UIView!
    @IBOutlet private weak var logoutView: UIView!
    
    // MARK: - Properties
    weak var delegate: MoveOtherScreenDelegate?
    
    // MARK: - View LifeCyrcle
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    // MARK: - Configuration
    private func setupLayout() {
        roundCorners(corners: [.topLeft, .topRight], radius: 15)
        viewLine.cornerView(cornerRadius: 2, borderWidth: 0.1, borderColor: Constants.Color.disabledGrey)
        settingView.cornerView(cornerRadius: settingView.frame.height/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        helpView.cornerView(cornerRadius: helpView.frame.height/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
        logoutView.cornerView(cornerRadius: logoutView.frame.height/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
    }
    
    // MARK: - IBActions
    @IBAction func settings() {

    }
    
    @IBAction func help() {
        
    }
    
    @IBAction func logOut() {
        let user = Auth.auth().currentUser!
        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
        onlineRef.removeValue { (error, _) in
            if let error = error {
                print("Removing online failed: \(error)")
                return
            }
            do {
                try Auth.auth().signOut()
                self.delegate?.selectLogOut()
            } catch (let error) {
                print("Auth sign out failed: \(error)")
            }
        }
    }
}


