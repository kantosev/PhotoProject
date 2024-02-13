//
//  PhotoCell.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 13.11.2022.
//

import UIKit


/// Фото - ячейка
final class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // каждый раз перед показом ячейки мы очищаем ее, тем самым не происходит неразберихи при переиспользовании ячеек
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil

    }

}
