//
//  CollectionViewModelProtocol.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.11.2022.
//

import Foundation
import Alamofire

protocol CollectionViewModelProtocol {
    func fetchOfData(with text: String, completion: @escaping (Bool) -> (), errorCompletion: @escaping (AFError) -> (), searchButtonPressed: Bool)
    func numberOfItemsInSection() -> Int
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath)
//    func sendRequestToDownloadLocation(indexPath: IndexPath)
    func getUserNames() -> [String]?
}
