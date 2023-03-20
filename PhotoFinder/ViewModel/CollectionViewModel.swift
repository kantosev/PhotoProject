//
//  CollectionViewModel.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.11.2022.
//

import UIKit
import Alamofire
import Kingfisher

class CollectionViewModel: CollectionViewModelProtocol {
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    
    private var arrayOfImages: [String]? = []
    private let url = "https://api.imgur.com/3/gallery/search/"
    private var text: String = ""
    private var countOfRepeatLoad: Int = 2
    
    func fetchOfData(with text: String, completion: @escaping (Bool) -> (), errorCompletion: @escaping (AFError) -> (), searchButtonPressed: Bool) {
        if searchButtonPressed == true {
            self.countOfRepeatLoad = 2
            self.text = text
            networkManager.getArrayOfImages(url: url, searchText: text, page: "1") { [weak self] arrayImages in
                if !arrayImages.isEmpty {
                    self?.arrayOfImages = arrayImages
                    completion(false)
                } else {
                    completion(true)
                }
            } errorCompletion: { error in
                errorCompletion(error)
            }
            
        } else {
            networkManager.getArrayOfImages(url: url, searchText: self.text, page: String(countOfRepeatLoad)) { arrayImages in
                if !arrayImages.isEmpty {
                    self.arrayOfImages?.append(contentsOf: arrayImages)
                    completion(false)
                    self.countOfRepeatLoad += 1
                } else {
                    completion(true)
                }
            } errorCompletion: { error in
                errorCompletion(error)
            }
            
        }
    }
    func numberOfItemsInSection() -> Int {
        return arrayOfImages?.count ?? 0
    }
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath) {
        if let arrayOfImages {
            guard let url = URL(string: arrayOfImages[indexPath.row]) else { return }
            DispatchQueue.main.async {
                cell.activityIndicator.startAnimating()
                cell.activityIndicator.hidesWhenStopped = true
                cell.imageView.kf.setImage(with: url, options: [.transition(.fade(0.4))]) {
                    _ in
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        
    }
    
    
}
