//
//  CollectionViewModelProtocol.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.11.2022.
//

import Foundation
import Alamofire

protocol CollectionViewModelProtocol {
    func fetchOfData(with text: String, searchButtonPressed: Bool, completion: @escaping (Bool) -> (), errorCompletion: @escaping (AFError) -> ())
    func numberOfItemsInSection() -> Int
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath)
    
}
