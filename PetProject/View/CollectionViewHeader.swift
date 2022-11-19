//
//  CollectionViewHeader.swift
//  PetProject
//
//  Created by Антон Кирилюк on 19.11.2022.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {

    @IBOutlet weak var searchTextField: UITextField!
    private var viewModel: CollectionViewModelProtocol?
    
    
    var searchText: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = CollectionViewModel()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        searchText = searchTextField.text ?? ""
        viewModel?.fetchOfData(with: searchText, completion: { 

        })
    }
}
