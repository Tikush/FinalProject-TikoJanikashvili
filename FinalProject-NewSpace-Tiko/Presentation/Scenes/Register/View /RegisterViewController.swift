//
//  RegisterViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var mailTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var eyeButton: UIButton!
    @IBOutlet private weak var passwordLineView: UIView!
    @IBOutlet private weak var mailLineView: UIView!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var phonetextField: UITextField!
    @IBOutlet private weak var nameLineView: UIView!
    
    // MARK: - Properties
    var alert = UIAlertController()
    private var isSecureTextEntryPassword = true
    var currentUser: User!
    private var viewModel: RegisterViewModelProtocol!

    // MARK: - Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()
        configuration()
        changeLineColors()
        configureViewModel()
    }
    
    private func configureViewModel() {
        let user = Auth.auth().currentUser
        if let user = user {
            currentUser = User(uid: user.uid, email: user.email ?? "", phone: user.phoneNumber ?? "")
        }
        viewModel = RegisterViewModel()
    }
    
    // MARK: - Configuration
    private func configuration() {
        mailTextfield.attributedPlaceholder = NSAttributedString(string: "მომხმარებელი", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "პაროლი", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        phonetextField.attributedPlaceholder = NSAttributedString(string: "სახელი", attributes: [NSAttributedString.Key.foregroundColor: Constants.Color.disabledGrey])
        registerButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
        eyeButton.isHidden = true
        passwordTextfield.delegate = self
        mailTextfield.delegate = self
    }
    
    private func showAlert() {
        alert = UIAlertController(title: "მონაცემები არ შეინახა", message: "გთხოვთ შეავსოთ ველები", preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true)
    }
    
    private func dismissAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
    }
    
    private func alertPasword() {
        alert = UIAlertController(title: "ინფო", message: "პაროლი უნდა იყოს 6 სიმბოლოზე მეტი, ან მეილის ფორმატი არის არასწორი", preferredStyle: UIAlertController.Style.alert)
        present(alert, animated: true)
    }
    
    // MARK: - IBActions
    @IBAction private func changeColorMail() {
        mailLineView.backgroundColor = Constants.Color.brandBlue
        eyeButton.isHidden = true
        if passwordTextfield.text != "" {
            passwordLineView.backgroundColor = Constants.Color.brandBlue
            eyeButton.isHidden = false
        } else {
            passwordLineView.backgroundColor = Constants.Color.keylineGrey
            eyeButton.isHidden = true
        }
    }
    
    @IBAction private func changeColorPassword() {
        eyeButton.isHidden = false
        passwordLineView.backgroundColor = Constants.Color.brandBlue
        if mailTextfield.text != "" {
            mailLineView.backgroundColor = Constants.Color.brandBlue
        } else {
            mailLineView.backgroundColor = Constants.Color.keylineGrey
        }
    }
    
    @IBAction private func changeColorName() {
        nameLineView.backgroundColor = Constants.Color.brandBlue
        eyeButton.isHidden = true
        if phonetextField.text != "" {
            nameLineView.backgroundColor = Constants.Color.brandBlue
            eyeButton.isHidden = false
        } else {
            nameLineView.backgroundColor = Constants.Color.keylineGrey
            eyeButton.isHidden = true
        }
    }
    
    @IBAction private func register() {
        guard let email = mailTextfield.text?.isNotEmpty,
            let password = passwordTextfield.text?.isNotEmpty,
            let phone = phonetextField.text else {
            showAlert()
            dismissAlert()
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if error == nil {
                Auth.auth().signIn(withEmail: email, password: password)
                print("Register")
                self.dismiss(animated: true, completion: nil)
                self.coordinator?.main()
                
                if let user = Auth.auth().currentUser {
                    let rootRef = Database.database().reference()
                    let userRef = rootRef.child("users").child(user.uid)
                    userRef.setValue(["uid": user.uid, "email": user.email, "phone": phone])
                }
            } else {
                self.alertPasword()
                self.dismissAlert()
            }
        }
        viewModel.addUserDetails(with: currentUser,
                                 refKey: RefPoints.userDetails.rawValue,
                                 userItem: UserItem(name: "user\(email.prefix(4))", amount: "7717", email: email, completed: false))
    }
    
    @IBAction private func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case mailTextfield:
            passwordTextfield.becomeFirstResponder()
            eyeButton.isHidden = false
            passwordLineView.backgroundColor = Constants.Color.brandBlue
        default:
            passwordTextfield.resignFirstResponder()
            register()
        }
        return false
    }
}

extension RegisterViewController {
    func changeLineColors() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeColor)))
    }
    
    @objc func changeColor(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        if mailTextfield.text != "" { mailLineView.backgroundColor = Constants.Color.brandBlue }
        else { mailLineView.backgroundColor = Constants.Color.keylineGrey }
        if passwordTextfield.text != "" {
            eyeButton.isHidden = false
            passwordLineView.backgroundColor = Constants.Color.brandBlue
        }
        else {
            eyeButton.isHidden = true
            passwordLineView.backgroundColor = Constants.Color.keylineGrey }
    }
}
