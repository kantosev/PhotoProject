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
    
    var user: User? = nil
    
    private var signManager: SignManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogIn()
        signManager = SignManager()
    }
    
    private func checkLogIn() {
        if let user = User.current {
            self.user = user
            performSegue(withIdentifier: "toMainVCfromSignInVC", sender: self)
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        guard let username = userNameOrEmailTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return AlertController.showAlertController(onViewController: self, title: "Error", message: "Данные введены неверно")
        }
        
        signManager?.logIn(username: username, password: password, onViewController: self) { user in
            self.user = user
            self.performSegue(withIdentifier: "toMainVCfromSignInVC", sender: self)
        }
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
       performSegue(withIdentifier: "toSignUpVCfromSignInVC", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainVCfromSignInVC" {
            let vc = segue.destination as? MainViewController
            vc?.user = user
        }
    }
    
    
}




