//
//  ViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 03.11.2022.
//

import UIKit
import ParseSwift


class SignInViewController: UIViewController {
    
    @IBOutlet weak var userNameOrEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var signManager: SignManagerProtocol?
    private var googleSignManager: GoogleSignManagerProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogIn()
        signManager = SignManager()
        googleSignManager = GoogleSignManager()
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
        
        signManager?.logIn(username: username, password: password, onViewController: self) { _ in
            self.performSegue(withIdentifier: "toMainVCfromSignInVC", sender: self)
        }
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



