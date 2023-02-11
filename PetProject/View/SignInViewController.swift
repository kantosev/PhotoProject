//
//  ViewController.swift
//  PetProject
//
//  Created by Ivan Eremeev on 03.11.2022.
//

import UIKit
import ParseSwift



class SignInViewController: UIViewController {
    
    @IBOutlet weak var userNameOrEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var signManager: SignManagerProtocol?
    private var googleSignManager: GoogleSignManagerProtocol?
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogIn()
        signManager = SignManager()
        googleSignManager = GoogleSignManager()
        registerForKeyboardNotifications()
        userNameOrEmailTextField.delegate = self
        passwordTextField.delegate = self
        setActivityIndicator()
        
    }
    // Проверка вошел ли уже пользователь до этого
    private func checkLogIn() {
        
        if (User.current != nil) {
            performSegue(withIdentifier: "toMainVCfromSignInVC", sender: self)
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        guard let username = userNameOrEmailTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return AlertController.showAlertController(onViewController: self, title: "Error", message: "Данные введены неверно")
        }
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        signManager?.logIn(username: username, password: password, onViewController: self) { _ in
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "toMainVCfromSignInVC", sender: self)
        }
        self.activityIndicator.stopAnimating()
    }
    
    
    @IBAction func signInGoogleButtonAction(_ sender: Any) {
        googleSignManager?.SignInWithGoogle(onViewController: self) { user in
            self.performSegue(withIdentifier: "toMainVCfromSignInVC", sender: self)
        }
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toSignUpVCfromSignInVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toMainVCfromSignInVC":
            navigationController?.setNavigationBarHidden(true, animated: false)
        case "toSignUpVCfromSignInVC":
            navigationController?.setNavigationBarHidden(false, animated: true)
        default:
            break
        }
        
    }
    
    
}

extension SignInViewController {
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        let userInfo = notification.userInfo!
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        if notification.name == UIResponder.keyboardWillShowNotification {
            bottomConstraint.constant = keyboardScreenEndFrame.height + 15
        }
        if notification.name == UIResponder.keyboardWillHideNotification {
            bottomConstraint.constant = 246
        }
        
        view.needsUpdateConstraints()
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    // нажатие кнопки return на клавиатуре обрабатывается
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    func setActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
