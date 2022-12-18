//
//  CollectionViewModelProtocol.swift
//  PetProject
//
//  Created by Антон Кирилюк on 19.11.2022.
//

import Foundation
import Alamofire

protocol CollectionViewModelProtocol {
    func fetchOfData(with text: String, completion: @escaping (Bool) -> (), errorCompletion: @escaping (AFError) -> ())
    func numberOfItemsInSection() -> Int
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath)
}
