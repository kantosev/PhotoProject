//
//  CollectionViewFooter.swift
//  PetProject
//
//  Created by Антон Кирилюк on 12.02.2023.
//

import UIKit

class CollectionViewFooter: UICollectionReusableView {

    var viewModel: CollectionViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewModel = CollectionViewModel()
        // Initialization code
    }
    
    @IBAction func footerButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("overImageLoad"), object: self)
    }
}
