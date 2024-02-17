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
final class CollectionViewModel: CollectionViewModelProtocol {
    
    // MARK: - Properties
    // Network Manager (получение данных из сети)
    private let networkManager: NetworkManagerProtocol
    // Массив ссылок на изображения
    private var arrayOfImages: [String]
    // url
    private let url: String = "https://api.imgur.com/3/gallery/search/"
    // Поисковый запрос
    private var text: String
    // Счетчик для смены page при запросе дополнительных изображений
    private var countOfRepeatLoad: Int
    
    // MARK: - init
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
        self.arrayOfImages = []
        self.text = ""
        self.countOfRepeatLoad = 1
    }
    
    // MARK: - Functions
    
    /// Получение массива ссылок на изображения
    /// - Parameters:
    ///   - text: Поисковый запрос
    ///   - completion: completion
    ///   - errorCompletion: В случае ошибки в запросе
    ///   - searchButtonPressed: true - нажата кнопка поиска, false - нажата кнопка "Загрузить еще"
    func fetchOfData(with text: String, searchButtonPressed: Bool, completion: @escaping (Bool) -> (), errorCompletion: @escaping (AFError) -> ()) {
        
        if searchButtonPressed == true {
            self.countOfRepeatLoad = 1
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
                    self.arrayOfImages.append(contentsOf: arrayImages)
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
        return arrayOfImages.count
    }
    
    /// Настройка ячейки CollectionView
    /// - Parameters:
    ///   - cell: Ячейка для настройки
    ///   - indexPath: Местоположение ячейки
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath) {
        guard let url = URL(string: arrayOfImages[indexPath.row]) else { return }
        DispatchQueue.main.async {
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: url, options: [.transition(.fade(0.4))]) { _ in }
        }
    }
}
