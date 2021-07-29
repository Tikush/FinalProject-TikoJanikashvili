//
//  CompanyDetailsViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 21.07.21.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import Firebase

class PayDetailsViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var companyImage: UIImageView!
    @IBOutlet private weak var moneyText: UITextField!
    @IBOutlet private weak var companyName: UILabel!
    @IBOutlet private weak var cardName: UILabel!
    @IBOutlet private weak var cardImage: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var detailInfoLabel: UILabel!
    
    // MARK: - Private Properties
    private var viewModel: PayDetailsViewModelProtocol!
    private var currenrUser: User!
    
    // MARK: - Internal Properties
    var name: String?
    var image: UIImage?
    var account: String?
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        dismissKeyboard()
        configureViewModel()
    }
    
    // MARK: - Setup layout
    private func setupLayout() {
        nextButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        companyImage.image = image
        companyName.text = name
        detailInfoLabel.text = account
        moneyText.delegate = self
    }
    
    private func configureViewModel() {
        viewModel = PayDetailsViewModel(with: self)
    }
    
    // MARK: - IBActions
    @IBAction private func back(_ sender: Any) {
        viewModel.controller.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func slideForCard(_ sender: Any) {
        print("slide")
    }
    
    @IBAction private func close(_ sender: Any) {
        viewModel.controller.navigationController?.popToRootViewController(animated: true)
    }

    
    @IBAction private func next(_ sender: Any) {
        let user = Auth.auth().currentUser
        if let user = user {
            currenrUser = User(uid: user.uid, email: user.email ?? "", phone: user.phoneNumber ?? "")
        }
        guard let companyName = companyName.text?.isNotEmpty,
              let amountText = moneyText.text?.isNotEmpty
              else { return }
        let paymentItem = PaymentItem(name: companyName,
                                      addedByUser: currenrUser?.email ?? "",
                                      completed: false,
                                      amount: amountText,
                                      time: currentTime())

        viewModel.controller.coordinator?.proceedToPaySuccessPage()
        viewModel.addPayment(with: currenrUser, refKey: RefPoints.payments.rawValue, paymentItem: paymentItem)
        viewModel.updateUser(with: currenrUser, refKey: RefPoints.userDetails.rawValue, amount: amountText)
    }
}

extension PayDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        moneyText.resignFirstResponder()
        return true
    }
}


