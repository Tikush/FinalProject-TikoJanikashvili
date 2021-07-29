//
//  InviteViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 27.07.21.
//

import UIKit

class InviteViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var copyCodeButton: UIButton!
    @IBOutlet private weak var inviteButton: UIButton!
    @IBOutlet private weak var backGroundView: UIView!
    @IBOutlet private weak var inviteImage: UIView!
    
    // MARK: - Private Properties
    private var viewModel: InviteViewModelProtocol!
    
    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
    }
    
    private func setupLayout() {
        backGroundView.cornerView(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        inviteImage.layer.cornerRadius = inviteImage.frame.height/2
        inviteButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    private func configureViewModel() {
        viewModel = InviteViewModel(with: self)
    }
    
    // MARK: - IBActions
    @IBAction private func onCopy(_ sender: Any) {
        UIButton.animate(
            withDuration: 1.0,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.copyCodeButton.setTitle(InviteConstants.copied, for: .normal)
            }
        )
    }
    
    @IBAction private func share(_ sender: UIButton) {
        let activityController = UIActivityViewController(activityItems: [" "], applicationActivities:  nil)
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            completed ? print(InviteConstants.completed) : print(InviteConstants.cencalled)
        }
        present(activityController, animated: true) {
            print(InviteConstants.presented)
        }
    }
    
    @IBAction private func copyText() {
        UIPasteboard.general.string = InviteConstants.inviteMessage + InviteConstants.link
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inviteFriend(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        viewModel.controller.coordinator?.proceedToInviteDetailsPage()
    }
}
