//
//  CompanyDetailsViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 21.07.21.
//

import UIKit
import Kingfisher

class CompanyDetailsViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var companyImage: UIImageView!
    @IBOutlet private weak var compyanyName: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var nextButton: UIButton!
    
    // MARK: Private Properties
    private var viewModel: CompanyDetailsViewModelProtocol!
    
    // MARK: - Internal Properties
    var name: String?
    var image: String?
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        getCompany()
        dismissKeyboard()
        configureViewModel()
    }
    
    // MARK: - Setup Layout
    private func setupLayout() {
//        companyImage.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
        nextButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        textField.delegate = self
    }
    
    private func getCompany() {
        compyanyName.text = self.name
        companyImage.kf.setImage(with: URL(string: image ?? ""))
    }
    
    private func configureViewModel() {
        viewModel = CompanyDetailsViewModel(with: self)
    }
    
    // MARK: - UIActions
    @IBAction private func back(_ sender: Any) {
        viewModel.controller.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func close(_ sender: Any) {
        viewModel.controller.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func next(_ sender: Any) {
        viewModel
            .controller
            .coordinator?
            .proceedToPayDetailsPage(with: compyanyName.text ?? ""
                                     ,companyImage: ((companyImage.image ?? UIImage(named: ""))!), account: textField.text ?? "" )
    }
}

extension CompanyDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
