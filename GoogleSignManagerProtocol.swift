//
//  GoogleSignManagerProtocol.swift
//  PetProject
//
//  Created by Ivan Eremeev on 06.11.2022.
//

import Foundation
import UIKit

protocol GoogleSignManagerProtocol {
    
    func SignInWithGoogle(onViewController vc: UIViewController, successCompletion: @escaping (User) -> ())
    
}
