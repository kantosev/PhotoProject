//
//  CollectionViewHeader.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.11.2022.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {

    @IBOutlet weak var searchTextField: UITextField!
    
    var searchText: String!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextField.placeholder = NSLocalizedString("Search image", comment: "Header placeholder")
        self.searchTextField.delegate = self
        // кнопка ввод скрыта до ввода первого символа
        searchTextField.enablesReturnKeyAutomatically = true
        
    }
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let searchText = searchTextField.text, !searchText.isEmpty else { return NotificationCenter.default.post(name: .init("errorSearch"), object: self, userInfo: nil) }
        let userInfo: [AnyHashable: Any] = ["text": searchText]
        NotificationCenter.default.post(name: .init("searchButtonPressed"), object: self, userInfo: userInfo)
        
    }
    
    
}

extension CollectionViewHeader: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }

    func performAction() {
        guard let searchText = searchTextField.text, !searchText.isEmpty else { return NotificationCenter.default.post(name: .init("errorSearch"), object: self, userInfo: nil) }
        let userInfo: [AnyHashable: Any] = ["text": searchText]
        NotificationCenter.default.post(name: .init("searchButtonPressed"), object: self, userInfo: userInfo)
    }
}

