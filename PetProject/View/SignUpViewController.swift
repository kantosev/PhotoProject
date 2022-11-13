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
    
    private var signManager: SignManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signManager = SignManager()
    }

    @IBAction func signUpButtonAction(_ sender: Any) {
        guard let login = signUpLoginTextField.text, !login.isEmpty, let password = signUpPasswordTextField.text, !password.isEmpty, let email = signupEmailTextField.text, !email.isEmpty, let age = signUpAgeTextField.text, !age.isEmpty
        else {
            return AlertController.showAlertController(onViewController: self, title: "Error", message: "Данные введены неверно", buttonTitle: "Ok", buttonStyle: .cancel)
        }
        signManager?.signUp(username: login, email: email, password: password, age: age, onViewController: self) {
            self.performSegue(withIdentifier: "toMainVCfromSignUpVC", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainVCfromSignUpVC" {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
}
