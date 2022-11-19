//
//  CollectionViewModel.swift
//  PetProject
//
//  Created by Антон Кирилюк on 19.11.2022.
//

import Foundation
import UIKit


class CollectionViewModel: CollectionViewModelProtocol {
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private var arrayOfImages: [String]?
    private let url = "https://imsea.herokuapp.com/api/1?q=dinosaur"
    
    func fetchOfData(completion: @escaping () -> ()) {
        networkManager.getArrayOfImages(url: url) { [weak self] arrayString in
            self?.arrayOfImages = arrayString
            completion()
        }
    }
    func numberOfItemsInSection() -> Int {
        return arrayOfImages?.count ?? 0
    }
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath) {
        if let arrayOfImages {
        guard let url = URL(string: arrayOfImages[indexPath.row]) else { return }
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    cell.imageView.image = image
                }
            }
        }
    }
}
