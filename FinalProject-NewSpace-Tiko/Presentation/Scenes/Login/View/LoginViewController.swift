//
//  LoginViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseFirestore

class LoginViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var mailTextfield: CustomTextField!
    @IBOutlet private weak var passwordTextfield: CustomTextField!
    @IBOutlet private weak var mailLineView: UIView!
    @IBOutlet private weak var passwordLineView: UIView!
    @IBOutlet private weak var eyeButton: UIButton!
    
    // MARK: - Properties
    private var isSecureTextEntryPassword = true
    var alert = UIAlertController()
    
    // MARK: - View LifeCyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        dismissKeyboard()
        changeLineColors()
    }
    
    // MARK: - Configuration
    private func setupLayout() {
        logInButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "პაროლი", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        mailTextfield.attributedPlaceholder = NSAttributedString(string: "მომხმარებელი", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        eyeButton.isHidden = true
        passwordTextfield.delegate = self
        mailTextfield.delegate = self
    }
    
    private func emptyFieldsAlert() {
        alert = UIAlertController(title: "ინფო", message: "გთხოვთ შეავსოთ ველები", preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true)
    }
    
    private func incorrectDataAlert() {
        alert = UIAlertController(title: "ინფო", message: "თქვენი მომხმარებელი ან პაროლი არასწორეა", preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true)
    }
    
    private func dismissAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
    }
    
    // MARK: - IBActions
    @IBAction private func logIn() {
        guard let email = self.mailTextfield.text?.isNotEmpty,
              let password = self.passwordTextfield.text?.isNotEmpty else {
            emptyFieldsAlert()
            dismissAlert()
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if error == nil {
                print("Log In")
                self.dismiss(animated: true, completion: nil)
            } else {
                self.incorrectDataAlert()
                self.dismissAlert()
            }
        }
        
        Auth.auth().addStateDidChangeListener() { _, user in
            if user != nil {
                self.coordinator?.main()
            }
        }
    }
    
    @IBAction private func changeColorMail(_ sender: Any) {
        self.mailLineView.backgroundColor = Constants.Color.brandBlue
        if self.passwordTextfield.text != "" {
            self.passwordLineView.backgroundColor = Constants.Color.brandBlue
            self.eyeButton.isHidden = false
        } else {
            self.passwordLineView.backgroundColor = Constants.Color.keylineGrey
            self.eyeButton.isHidden = true
        }
    }
    
    @IBAction private func changeColorPassword(_ sender: Any) {
        self.eyeButton.isHidden = false
        self.passwordLineView.backgroundColor = Constants.Color.brandBlue
        if self.mailTextfield.text != "" {
            self.mailLineView.backgroundColor = Constants.Color.brandBlue
        } else {
            self.mailLineView.backgroundColor = Constants.Color.keylineGrey
        }
    }
    
    @IBAction private func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func showPassword(_ sender: Any) {
        if isSecureTextEntryPassword {
            eyeButton.setImage(UIImage(named: "ic_opened_eye"), for: .normal)
            passwordTextfield.isSecureTextEntry = false
            isSecureTextEntryPassword = false
        } else {
            eyeButton.setImage(UIImage(named: "ic_closed_eye"), for: .normal)
            passwordTextfield.isSecureTextEntry = true
            isSecureTextEntryPassword = true
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case mailTextfield:
            passwordTextfield.becomeFirstResponder()
            passwordLineView.backgroundColor = Constants.Color.brandBlue
            eyeButton.isHidden = false
        default:
            passwordTextfield.resignFirstResponder()
            logIn()
        }
        return true
    }
}

extension LoginViewController {
    func changeLineColors() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.changeColor)))
    }
    
    @objc func changeColor(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
            if mailTextfield.text != "" {
                mailLineView.backgroundColor = Constants.Color.brandBlue
            } else {
                mailLineView.backgroundColor = Constants.Color.keylineGrey }
            if passwordTextfield.text != "" {
                eyeButton.isHidden = false
                passwordLineView.backgroundColor = Constants.Color.brandBlue
            }
            else {
                eyeButton.isHidden = true
                passwordLineView.backgroundColor = Constants.Color.keylineGrey }
        }
    }
}

