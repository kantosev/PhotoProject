//
//  CollectionView + Search.swift
//  PetProject
//
//  Created by Антон Кирилюк on 12.02.2023.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - Observer
extension CollectionViewController {
    @objc func searchButtonPressed(notification: Notification) {
        // очищает кеш фото при новом поиске
        KingfisherManager.shared.cache.clearCache()
        footerIsHidden = false
        view.endEditing(true)
        if NetworkMonitor.shared.isConnected == true {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
            guard let userInfo = notification.userInfo else { return }
            guard let text = userInfo["text"] as? String else { return }
            
            viewModel?.fetchOfData(with: text, completion: { [activityIndicator, collectionView] arrayIsEmpty in
                activityIndicator?.stopAnimating()
                if arrayIsEmpty == false {
                    collectionView?.reloadData()
                } else {
                    AlertController.showAlertController(onViewController: self, title: "Ошибка", message: "Изображений по запросу не найдено")
                }
            }, errorCompletion: { [activityIndicator] error in
                AlertController.showAlertController(onViewController: self, title: "Ошибка загрузки данных", message: "Данные не были загружены, попробуйте позже")
                activityIndicator?.stopAnimating()
            }, searchButtonPressed: true)
        } else {
            AlertController.showAlertController(onViewController: self, title: "Ошибка соединения", message: "Нет соединения с интернетом")
        }
    }
    @objc func errorSearch() {
        AlertController.showAlertController(onViewController: self, title: "Error", message: "Вы ничего не ввели")
    }
    
    @objc func overButtonLoadPressed() {
        
        viewModel?.fetchOfData(with: "", completion: { [collectionView] arrayIsEmpty in
            if arrayIsEmpty == false {
                collectionView?.reloadData()
            } else {
                AlertController.showAlertController(onViewController: self, title: "Неудачно", message: "Изображений больше нет")
            }
        }, errorCompletion: { error in
            AlertController.showAlertController(onViewController: self, title: "Ошибка загрузки данных", message: "Данные не были загружены, попробуйте позже")
        }, searchButtonPressed: false)
    }
    
    }
