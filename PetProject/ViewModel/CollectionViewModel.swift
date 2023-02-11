//
//  CollectionViewModel.swift
//  PetProject
//
//  Created by Ivan Eremeev on 19.11.2022.
//

import UIKit
import Alamofire
import Kingfisher

class CollectionViewModel: CollectionViewModelProtocol {
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    
    private var arrayOfImages: [String]?
    private let url = "https://api.unsplash.com/search/photos"
    
    func fetchOfData(with text: String, completion: @escaping (Bool) -> (), errorCompletion: @escaping (AFError) -> ()) {
        networkManager.getArrayOfImages(url: url, searchText: text) { [weak self] array in
            if !array.isEmpty {
                self?.arrayOfImages = array
                completion(false)
            } else {
                completion(true)
            }
            
        } errorCompletion: { error in
            errorCompletion(error)
        }

    }
    func numberOfItemsInSection() -> Int {
        return arrayOfImages?.count ?? 0
    }
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath) {
        if let arrayOfImages {
        guard let url = URL(string: arrayOfImages[indexPath.row]) else { return }
                DispatchQueue.main.async {
                    cell.imageView.kf.setImage(with: url)
                }
            
        }
    }
}
