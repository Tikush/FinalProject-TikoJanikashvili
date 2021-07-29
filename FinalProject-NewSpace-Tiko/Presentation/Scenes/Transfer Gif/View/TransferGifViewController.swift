//
//  TransferGifViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 23.07.21.
//

import UIKit
import Kingfisher
import Firebase

class TransferGifViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var gifImageView: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet private weak var contactSymbolLabel: UILabel!
    @IBOutlet private weak var contactNumberLabel: UILabel!
    @IBOutlet private weak var contactImageView: UIImageView!
    @IBOutlet private weak var moneyLabel: UILabel!
    @IBOutlet private weak var payButton: UIButton!
    
    // MARK: - Internal Properties
    var money: String?
    var number: String?
    var symbol: String?
    var name: String?
    
    // MARK: - Private Properties
    private var viewModel: TransferGifViewModelProtocol!
    private var gif: SliderForGifProtocol!
    private var currenrUser: User!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        dismissKeyboard()
        configureViewModel()
    }
    
    private func setupLayout() {
        contactImageView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
        payButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        gifImageView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
        contactNameLabel.text = name
        contactNumberLabel.text = number
        moneyLabel.text = money
        contactSymbolLabel.text = symbol
        gifImageView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
        gifImageView.isHidden = true
        closeButton.isHidden = true
    }
    
    private func configureViewModel() {
        viewModel = TransferGifViewModel(with: self)
        gif = SliderForGif(with: self)
        
    }
    
    // MARK: - IBActions
    @IBAction private func close(_ sender: Any) {
        viewModel.controller.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func back(_ sender: Any) {
        viewModel.controller.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func deleteGifImage(_ sender: Any) {
        gifImageView.isHidden = true
        closeButton.isHidden = true
    }
    
    @IBAction private func onGif(_ sender: Any) {
        gif.loadSlide(gifSearching: true)
        gif.delegate = self
    }
    
    @IBAction private func next(_ sender: Any) {
        let user = Auth.auth().currentUser
        if let user = user {
            currenrUser = User(uid: user.uid, email: user.email ?? "", phone: "")
        }
        guard let number = contactNumberLabel.text?.isNotEmpty,
              let amount = moneyLabel.text?.isNotEmpty,
              let name = contactNameLabel.text?.isNotEmpty
              else { return }
        let title = "\(name) თქვენ ჩაგერიცხათ თანხა \(amount)"
        let transferItem = TransferItem(name: title,
                                       completed: false,
                                       amount: amount,
                                       time: currentTime(),
                                       recieverId: number,
                                       senderId: currenrUser.email)
        
        viewModel.transferMoney(with: currenrUser, refKey: "transfer-items", transferItem: transferItem)
        viewModel.controller.coordinator?.proceedToTransferPayPage()
    }
}

extension TransferGifViewController: SlideDelegate {
    func selectGif(url: String) {
        self.gifImageView.kf.setImage(with: URL(string: url))
        self.gifImageView.isHidden = false
        self.closeButton.isHidden = false
    }
}
