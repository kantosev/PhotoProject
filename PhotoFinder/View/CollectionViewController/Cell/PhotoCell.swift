//
//  PhotoCell.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 13.11.2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var userNameLabel: UILabel!
    var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLabel()
        imageView.addSubview(userNameLabel)
        setActivityIndicatorOnCell()
        
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
    func setActivityIndicatorOnCell() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
