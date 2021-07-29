//
//  TransferViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 19.07.21.
//

import UIKit

class TransferViewController: BaseViewController {

    // MARk: - IBOutlets
    @IBOutlet weak var transferButton: UIButton!
    
    // MARK: Private Properties
    private var viewModel: TransferViewModelProtocol!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
    }
    
    private func setupLayout() {
        transferButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    private func configureViewModel() {
        viewModel = TransferViewModel(with: self)
    }
    
    // MARK: - IBActions
    @IBAction private func onTranfer(_ sender: Any) {
        viewModel.controller.coordinator?.proceedToTransferDerailsPage()
    }
}
