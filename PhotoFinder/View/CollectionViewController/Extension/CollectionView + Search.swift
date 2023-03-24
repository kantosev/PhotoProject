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
                    AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error1"), message: NSLocalizedString("No images found on request", comment: "No images found on request"))
                }
            }, errorCompletion: { [activityIndicator] error in
                AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Data loading error", comment: "Data loading error"), message: NSLocalizedString("The data was not uploaded, try again later", comment: "The data was not uploaded, try again later"))
                activityIndicator?.stopAnimating()
            }, searchButtonPressed: true)
        } else {
            AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Connection error", comment: "Connection error"), message: NSLocalizedString("No internet connection", comment: "No internet connection"))
        }
    }
    @objc func errorSearch() {
        AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error2"), message: NSLocalizedString("You haven't entered anything", comment: "You haven't entered anything"))
    }
    
    @objc func overButtonLoadPressed() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        viewModel?.fetchOfData(with: "", completion: { [collectionView] arrayIsEmpty in
            self.activityIndicator?.stopAnimating()
            if arrayIsEmpty == false {
                collectionView?.reloadData()
            } else {
                AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error3"), message: NSLocalizedString("There are no more images", comment: "There are no more images"))
            }
        }, errorCompletion: { error in
            self.activityIndicator?.stopAnimating()
            AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Data loading error", comment: "Data loading error"), message: NSLocalizedString("The data was not uploaded, try again later", comment: "The data was not uploaded, try again later"))
        }, searchButtonPressed: false)
    }
    
    }
