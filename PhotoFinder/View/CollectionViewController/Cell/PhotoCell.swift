//
//  PhotoCell.swift
//  PetProject
//
//  Created by Ivan Eremeev on 13.11.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var userNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
        imageView.addSubview(userNameLabel)
        
    }
    // каждый раз перед показом ячейки мы очищаем ее, тем самым не происходит неразберихи при переиспользовании ячеек
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    private func setLabel() {
        userNameLabel = UILabel(frame: CGRect(x: 5, y: self.frame.height + 18, width: imageView.frame.width, height: 10))
        userNameLabel.textColor = .systemGray
//        userNameLabel.font = UIFont(name: "System Italic", size: 5)
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.numberOfLines = 0
        userNameLabel.textAlignment = .justified
    }
}