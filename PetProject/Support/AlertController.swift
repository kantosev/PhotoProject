//
//  AlertController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 04.11.2022.
//

import Foundation
import UIKit

class AlertController {
    
    static func showAlertController(onViewController vc: UIViewController, title: String, message: String, buttonTitle: String = "Ok", buttonStyle: UIAlertAction.Style = .cancel, completion: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: buttonStyle) { _ in 
            alertController.dismiss(animated: true)
            completion?()
        }
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true)
    }
}


