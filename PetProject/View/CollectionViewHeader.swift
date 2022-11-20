//
//  CollectionViewHeader.swift
//  PetProject
//
//  Created by Антон Кирилюк on 19.11.2022.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {

    @IBOutlet weak var searchTextField: UITextField!
    
    var searchText: String!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchText = searchTextField.text ?? ""
        let userInfo: [AnyHashable: Any] = ["text": searchText!]
        NotificationCenter.default.post(name: .init("searchButtonPressed"), object: self, userInfo: userInfo)
    }
}
