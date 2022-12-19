//
//  SignUp.swift
//  PetProject
//
//  Created by Антон Кирилюк on 04.11.2022.
//

import Foundation
import ParseSwift
import UIKit

class SignManager: SignManagerProtocol {
    
    func signUp(username: String, email: String?, password: String, age: String, onViewController vc: UIViewController, completionToSuccessAlert: (() -> ())?) {
        let newUser = User(username: username, email: email, password: password, age: age)
        
        
        // The below registers the user asynchronously and returns the updated User object (stored on your Back4App application) wrapped in a Result<User, ParseError> object
        newUser.signup { result in
            switch result {
            case .success:
                AlertController.showAlertController(onViewController: vc, title: "Signup succeeded", message: "Вы зарегистрированы", buttonTitle: "Ok", completion: { completionToSuccessAlert?() })
            case .failure(let error):
                AlertController.showAlertController(onViewController: vc, title: "Error", message: error.message)
                print(error.code, error.debugDescription)
            }
        }
    }
    func logIn(username: String, password: String, onViewController vc: UIViewController, successCompletion: @escaping (User) -> ()) {
        // Logs in the user asynchronously
        
        User.login(username: username, password: password) { result in // Handle the result (of type Result<User, ParseError>)
            switch result {
            case .success(let loggedInUser):
                successCompletion(loggedInUser)
            case .failure(let error):
                AlertController.showAlertController(onViewController: vc, title: "Error", message: "\(error.debugDescription)")
            }
        }
    }
    func logOut(successCompletion: @escaping () -> (), errorCompletion: @escaping (Error) -> ()) {
        // Logs out the user asynchronously
        User.logout { result in // Handle the result (of type Result<Void, ParseError>)
            switch result {
            case .success:
                successCompletion()
            case .failure(let error):
                errorCompletion(error)
            }
        }
    }
    func deleteAccount(successCompletion: @escaping () -> (), errorCompletion: @escaping (Error) -> ()) {
        guard let currentUser = User.current else { return }
        currentUser.delete { result in
            switch result {
            case .success:
                successCompletion()
            case .failure(let error):
                errorCompletion(error)
            }
        }
    }
    func updateAccount(userName: String, email: String, age: String, successCompletion: @escaping () -> (), errorCompletion: @escaping (Error) -> ()) {
        guard var currentUser = User.current else { return }
        
        
        if !userName.isEmpty {
            currentUser.username = userName
        }
        if !email.isEmpty {
            currentUser.email = email
        }
        if !age.isEmpty {
            currentUser.age = age
        }
        currentUser.save { result in
            switch result {
            case .success:
                successCompletion()
            case .failure(let error):
                errorCompletion(error)
            }
        }
    }
    
}
