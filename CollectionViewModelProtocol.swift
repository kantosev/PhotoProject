//
//  CollectionViewModelProtocol.swift
//  PetProject
//
//  Created by Антон Кирилюк on 19.11.2022.
//

import Foundation

protocol CollectionViewModelProtocol {
    func fetchOfData(completion: @escaping () -> ())
    func numberOfItemsInSection() -> Int
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath)
}
