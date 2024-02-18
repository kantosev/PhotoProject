//
//  CollectionView + Search.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 12.02.2023.
//

import Foundation
import UIKit
import Kingfisher


extension CollectionViewController {
    
    /// Нажатие кнопки поиска изображений
    @objc func searchButtonPressed(notification: Notification) {
        
        // очищает кеш фото при новом поиске
        KingfisherManager.shared.cache.clearCache()
        
        footerIsHidden = false
        view.endEditing(true)
        // Есть соединение с интернетом
        if networkMonitor.isConnected == true {
            guard let userInfo = notification.userInfo else { return }
            guard let text = userInfo["text"] as? String else { return }
            
            viewModel?.fetchOfData(with: text, searchButtonPressed: true) { [collectionView] result in
                NotificationCenter.default.post(name: .init("stopActivityIndicator"), object: self, userInfo: nil)
                
                switch result {
                case .success(let arrayIsEmpty):
                    if arrayIsEmpty == false {
                        collectionView?.reloadData()
                    } else {
                        AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("No images found on request", comment: "No images found on request"))
                    }
                case .failure(_):
                    AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Data loading error", comment: "Data loading error"), message: NSLocalizedString("The data was not uploaded, try again later", comment: "The data was not uploaded, try again later"))
                    NotificationCenter.default.post(name: .init("stopActivityIndicator"), object: self, userInfo: nil)
                }
            }
            
            
            // Нет соединения с интернетом
        } else {
            AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Connection error", comment: "Connection error"), message: NSLocalizedString("No internet connection", comment: "No internet connection"))
        }
    }
    
    /// Что делать при ошибке поиска
    @objc func errorSearch() {
        AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("You haven't entered anything", comment: "You haven't entered anything"))
    }
    
    /// Нажата кнопка "Загрузить еще"
    @objc func overButtonLoadPressed() {
        viewModel?.fetchOfData(with: "", searchButtonPressed: false) { [collectionView] result in
            NotificationCenter.default.post(name: .init("stopActivityIndicator"), object: self, userInfo: nil)
            switch result {
            case .success(let arrayIsEmpty):
                if arrayIsEmpty == false {
                    collectionView?.reloadData()
                } else {
                    AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("There are no more images", comment: "There are no more images"))
                }
            case .failure(_):
                NotificationCenter.default.post(name: .init("stopActivityIndicator"), object: self, userInfo: nil)
                AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Data loading error", comment: "Data loading error"), message: NSLocalizedString("The data was not uploaded, try again later", comment: "The data was not uploaded, try again later"))
            }
        }
    }
}
