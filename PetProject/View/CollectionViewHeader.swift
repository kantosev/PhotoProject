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
        // Initialization code
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchText = searchTextField.text ?? ""
    }
}
