//
//  CollectionView + Keyboard.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 12.02.2023.
//

import Foundation
import UIKit


extension CollectionViewController: UITextFieldDelegate {
    
    /// обрабатывается нажатие кнопки return на клавиатуре 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
