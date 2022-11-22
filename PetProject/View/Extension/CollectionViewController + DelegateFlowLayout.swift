//
//  CollectionViewController + support.swift
//  PetProject
//
//  Created by Антон Кирилюк on 20.11.2022.
//

import Foundation
import UIKit

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    // layout.itemSize почему то не работает, поэтому использую метод делегата
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 2 - 10 - 5
        return CGSize(width: width, height: width)
    }
    // размеры header'a
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 0, right: 10)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout?.minimumLineSpacing = 10
        // header виден даже при прокрутке
        layout?.sectionHeadersPinToVisibleBounds = true
    }
}
