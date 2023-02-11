//
//  GoogleSignManager.swift
//  PetProject
//
//  Created by Ivan Eremeev on 06.11.2022.
//

import Foundation
import UIKit
import GoogleSignIn


class GoogleSignManager: GoogleSignManagerProtocol {
    func SignInWithGoogle(onViewController vc: UIViewController, successCompletion: @escaping (User) -> ()) {
        let signInConfig = GIDConfiguration(clientID: "264601043832-18u1gf418cnte5r1f4vlg9vj74l3tsn0.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: vc) { googleUser, error in
            if let error = error {
                return AlertController.showAlertController(onViewController: vc, title: "Error", message: error.localizedDescription)
            }
            //After Google returns a successful sign in, we get the users id and idToken
            guard let googleUser = googleUser,
                  let userId = googleUser.userID,
                  let idToken = googleUser.authentication.idToken
            else { fatalError("This should never happen!?") }
            
            // TODO: Sign in the user in your Back4App application.
            // With the user information returned by Google, you need to sign in the user on your Back4App application
            User.google.login(id: userId, idToken: idToken) { result in
                // Returns the User object asociated to the GIDGoogleUser object returned by Google
                switch result {
                case .success(let user):
                    // After the login succeeded, we send the user to the home screen
                    // Additionally, you can complete the user information with the data provided by Google
                    successCompletion(user)
                case .failure(let error):
                    // Handle the error if the login process failed
                    AlertController.showAlertController(onViewController: vc, title: "Ошибка входа", message: error.message)
                }
            }
        }
    }
}
