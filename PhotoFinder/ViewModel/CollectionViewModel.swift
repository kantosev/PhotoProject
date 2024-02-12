//
//  CollectionViewModel.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.11.2022.
//

import UIKit
import Alamofire
import Kingfisher

/// View Model для CollectionViewController
class CollectionViewModel: CollectionViewModelProtocol {
    
    // Network Manager (получение данных из сети)
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    // Массив ссылок на изображения
    private var arrayOfImages: [String]? = []
    // url
    private let url = "https://api.imgur.com/3/gallery/search/"
    // Поисковый запрос
    private var text: String = ""
    
    private var countOfRepeatLoad: Int = 2
    
    
    /// Получение массива ссылок на изображения
    /// - Parameters:
    ///   - text: Поисковый запрос
    ///   - completion: completion
    ///   - errorCompletion: В случае ошибки в запросе
    ///   - searchButtonPressed: <#searchButtonPressed description#>
    func fetchOfData(with text: String, completion: @escaping (Bool) -> (), errorCompletion: @escaping (AFError) -> (), searchButtonPressed: Bool) {
        if searchButtonPressed == true {
            self.countOfRepeatLoad = 2
            self.text = text
            networkManager.getArrayOfImages(url: url, searchText: text, page: "0") { [weak self] arrayImages in
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
    
    
    /// Расчет количества item в CollectionView
    /// - Returns: Количество item в CollectionView
    func numberOfItemsInSection() -> Int {
        return arrayOfImages?.count ?? 0
    }
    
    /// Настройка ячейки CollectionView
    /// - Parameters:
    ///   - cell: Ячейка для настройки
    ///   - indexPath: Местоположение ячейки
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath) {
        if let arrayOfImages {
            guard let url = URL(string: arrayOfImages[indexPath.row]) else { return }
            DispatchQueue.main.async {
                cell.imageView.kf.indicatorType = .activity
                cell.imageView.kf.setImage(with: url, options: [.transition(.fade(0.4))]) { _ in
                }
                
            }
        }
    }
}
