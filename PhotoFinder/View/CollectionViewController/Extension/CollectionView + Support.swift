//
//  CollectionView + Support.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 20.11.2022.
//

import Foundation
import UIKit
 

extension CollectionViewController {
    
    // MARK: - Observers
    
    /// Добавление наблюдателя за нажатием кнопки поиска
    func addObserverForTouchSearchButton() {
       notificationCenter.addObserver(self, selector: #selector(searchButtonPressed), name: .init("searchButtonPressed"), object: nil)
    }
    /// Добавление наблюдателя за ошибкой поискового запроса
    func addObserverForErrorSearch() {
        notificationCenter.addObserver(self, selector: #selector(errorSearch), name: .init("errorSearch"), object: nil)
    }
    /// Добавление наблюдателя за нажатием кнопки "Загрузить еще"
    func addObserverForOverButtonLoadPressed() {
        notificationCenter.addObserver(self, selector: #selector(overButtonLoadPressed), name: .init("overImageLoad"), object: nil)
    }
    
    // MARK: - View
    
    /// Регистрации фото-ячейки, Header'a и Footer'a
    func registerView() {
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(UINib(nibName: "CollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(UINib(nibName: "CollectionViewFooter", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
    }

}



