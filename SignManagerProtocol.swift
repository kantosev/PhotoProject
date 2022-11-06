//
//  SignManagerProtocol.swift
//  PetProject
//
//  Created by Антон Кирилюк on 06.11.2022.
//

import Foundation
import UIKit

protocol SignManagerProtocol {
    
    func signUp(username: String, email: String?, password: String, age: String, onViewController vc: UIViewController, completionToSuccessAlert: (() -> ())?)
    
    func logIn(username: String, password: String, onViewController vc: UIViewController, successCompletion: @escaping (User) -> ())
    
    func logOut(onViewController vc: UIViewController, successCompletion: @escaping () -> ())
}
