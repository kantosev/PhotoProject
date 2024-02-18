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
    ///   - completion: Доп. действие по нажатию кнопки
    static func showAlertController(onViewController vc: UIViewController, title: String, message: String, buttonTitle: String = "Ok", buttonStyle: UIAlertAction.Style = .cancel, completion: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: buttonTitle, style: buttonStyle) { _ in 
            alertController.dismiss(animated: true)
            completion?()
        }
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true)
    }
    
    
    /// Показать alert при запрете доступа к галерее
    /// - Parameter vc: На каком VC
    static func galleryAccessIsDenied(onViewController vc: UIViewController) {
        let alertController = UIAlertController(title: "Ошибка", message: "Невозможно сохранить. Разрешите доступ к галерее.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Разрешить", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true)
    }
}


