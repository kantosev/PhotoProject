//
//  SignManagerProtocol.swift
//  PetProject
//
//  Created by Ivan Eremeev on 06.11.2022.
//

import Foundation
import UIKit

protocol SignManagerProtocol {
    
    func signUp(username: String, email: String?, password: String, age: String, onViewController vc: UIViewController, completionToSuccessAlert: (() -> ())?)
    
    func logIn(username: String, password: String, onViewController vc: UIViewController, successCompletion: @escaping () -> (), errorCompletion: @escaping () -> ())
    
    func logOut(successCompletion: @escaping () -> (), errorCompletion: @escaping (Error) -> ())
    
    func deleteAccount(successCompletion: @escaping () -> (), errorCompletion: @escaping (Error) -> ())
    
    func updateAccount(userName: String, email: String, age: String, successCompletion: @escaping () -> (), errorCompletion: @escaping (Error) -> ())
}
