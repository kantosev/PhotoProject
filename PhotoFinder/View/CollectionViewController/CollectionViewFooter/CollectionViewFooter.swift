//
//  CollectionViewFooter.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 12.02.2023.
//

import UIKit

/// Кнопка загрузки дополнительных изображений
final class CollectionViewFooter: UICollectionReusableView {

    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitle(NSLocalizedString("Download more", comment: "Footer Button"), for: .normal)
        // Initialization code
    }
    
    /// Нажатие кнопки
    @IBAction func footerButtonPressed(_ sender: UIButton) {
        NotificationCenter.default.post(name: .init("overImageLoad"), object: self)
    }
}
