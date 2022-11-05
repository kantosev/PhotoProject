//
//  SignUpViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 04.11.2022.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpLoginTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signupEmailTextField: UITextField!
    @IBOutlet weak var signUpAgeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signUpButtonAction(_ sender: Any) {
        guard let login = signUpLoginTextField.text, let password = signUpPasswordTextField.text, let email = signupEmailTextField.text, let age = signUpAgeTextField.text
        else {
            return AlertController.showAlertController(onViewController: self, title: "Error", message: "Данные введены неверно", buttonTitle: "Ok", buttonStyle: .cancel)
        }
        SignManager.signUp(username: login, email: email, password: password, age: age, onViewController: self) {
            self.performSegue(withIdentifier: "toMainVCfromSignUpVC", sender: self)
        }
    }
    
}
