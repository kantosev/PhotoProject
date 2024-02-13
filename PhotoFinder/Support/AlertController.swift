//
//  AlertController.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 04.11.2022.
//

import Foundation
import UIKit

/// Объект для показа Alert Controller
final class AlertController {
    
    /// Показать alert
    /// - Parameters:
    ///   - vc: На каком VC
    ///   - title: Заголовок
    ///   - message: Сообщение
    ///   - buttonTitle: Название кнопки
    ///   - buttonStyle: Стиль кнопки
    ///   - completion: Действие по нажатию кнопки
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


