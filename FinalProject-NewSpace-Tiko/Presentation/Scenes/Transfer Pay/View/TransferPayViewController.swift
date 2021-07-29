//
//  TransferPayViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 23.07.21.
//

import UIKit

class TransferPayViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var mainButton: UIButton!
    
    // MARK: - Private Properties
    private var viewModel: TransferPayViewModelProtocol!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
    }
    
    private func setupLayout() {
        mainButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    private func configureViewModel() {
        viewModel = TransferPayViewModel(with: self)
    }

    // MARK: - IBActions
    @IBAction private func onMain(_ sender: Any) {
        viewModel.controller.navigationController?.popToRootViewController(animated: true)
    }
}
