//
//  AccountViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 26.07.21.
//

import UIKit
import Firebase

class AccountViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var contactView: UIView!
    
    // MARK: - Private Properties
    private var sliderSettings: AccountSettingView?
    private var sliderBackground: UIView?
    private var viewModel: AccountViewModelProtocol!
    private var slide: SliderForAccountProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configureViewModel()
        
        let user = Auth.auth().currentUser
        
        if let user = user {
            usernameLabel.text = user.email
//            currenrUser = User(uid: user.uid, email: user.email ?? "")
        }
        
//        ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
//            var newItems: [PaymentItem] = []
//            for child in snapshot.children {
//                if let snapshot = child as? DataSnapshot,
//                   let groceryItem = PaymentItem(snapshot: snapshot) {
//                    newItems.append(groceryItem)
//                }
//            }
//            self.items = newItems
//        })
//
//        let text = "hhhh"
//        let groceryItem = PaymentItem(name: text,
//                                      addedByUser: currenrUser?.email ?? "",
//                                      completed: false)
//        let groceryItemRef = self.ref.child(text.lowercased())
//
//        groceryItemRef.setValue(groceryItem.toAnyObject())
//        self.items.append(groceryItem)
    }
    
    private func setupLayout() {
        self.contactView.cornerView(cornerRadius: contactView.frame.height/2, borderWidth: 1, borderColor: Constants.Color.keylineGrey)
    }
    
    private func configureViewModel() {
        viewModel = AccountViewModel(with: self)
        slide = SliderForAccount(with: self)
    }
    
    // MARK: - IBActions
    @IBAction private func signOut() {
        slide.loadSlide()
    }
}
