//
//  CollectionViewHeader + Delegate.swift
//  PhotoFinder
//
//  Created by Anton Kirilyuk on 18.02.2024.
//

import Foundation
import UIKit


extension CollectionViewHeader: UITextFieldDelegate {
    
    /// Добавление возможности по нажатию кнопки return на клавиатуре поиска изображений
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction() {
        guard let searchText = searchTextField.text, !searchText.isEmpty else { return NotificationCenter.default.post(name: .init("errorSearch"), object: self, userInfo: nil) }
        let userInfo: [AnyHashable: Any] = ["text": searchText]
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NotificationCenter.default.post(name: .init("searchButtonPressed"), object: self, userInfo: userInfo)
    }
    
}
