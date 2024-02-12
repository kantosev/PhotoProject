//
//  CollectionViewFooter.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 12.02.2023.
//

import UIKit

class CollectionViewFooter: UICollectionReusableView {

    @IBOutlet weak var button: UIButton!
    var viewModel: CollectionViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitle(NSLocalizedString("Download more", comment: "Footer Button"), for: .normal)
        viewModel = CollectionViewModel()
        // Initialization code
    }
    
    @IBAction func footerButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("overImageLoad"), object: self)
    }
}
