//
//  PaymentViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

class PaymentViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var paymentButton: UIButton!
    
    // MARK: Private Properties
    private var viewModel: PaymentViewModelProtocol!
    
    //MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
    }
    
    private func setupLayout() {
        paymentButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    private func configureViewModel() {
        viewModel = PaymentViewModel(with: self)
    }
    
    //MARK: - IBActions
    @IBAction private func onPayment(_ sender: Any) {
        viewModel.controller.coordinator?.proceedToPaymentDetailsPage()
    }
}
