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
    
    private var arrayOfImages: [String]? = []
    private var arrayOfUserName: [String]? = []
    private let url = "https://api.unsplash.com/search/photos"
    private var text: String = ""
    private var countOfRepeatLoad: Int = 2
    
    func fetchOfData(with text: String, completion: @escaping (Bool) -> (), errorCompletion: @escaping (AFError) -> (), searchButtonPressed: Bool) {
        if searchButtonPressed == true {
            self.countOfRepeatLoad = 2
            self.text = text
            networkManager.getArrayOfImages(url: url, searchText: text, page: "1") { [weak self] arrayImages, arrayUserName in
                if !arrayImages.isEmpty {
                    self?.arrayOfImages = arrayImages
                    self?.arrayOfUserName = arrayUserName
                    completion(false)
                } else {
                    completion(true)
                }
            } errorCompletion: { error in
                errorCompletion(error)
            }
        } else {
            networkManager.getArrayOfImages(url: url, searchText: self.text, page: String(countOfRepeatLoad)) { arrayImages, arrayUserName in
                if !arrayImages.isEmpty {
                    self.arrayOfImages?.append(contentsOf: arrayImages)
                    self.arrayOfUserName?.append(contentsOf: arrayUserName)
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
                cell.imageView.kf.setImage(with: url, options: [.transition(.fade(0.4))])
            }
        }
        if let arrayOfUserName {
            DispatchQueue.main.async {
                cell.userNameLabel.text = "Photo by \(arrayOfUserName[indexPath.row]) on Unsplash"
            }
        }
        
    }
}
