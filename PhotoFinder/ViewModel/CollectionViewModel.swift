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
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.arrayOfImages = []
        self.text = ""
        self.countOfRepeatLoad = 1
    }
    
    // MARK: - Functions
    
    /// Получение массива ссылок на изображения
    /// - Parameters:
    ///   - text: Поисковый запрос
    ///   - completion: Результат запроса
    ///   - searchButtonPressed: true - нажата кнопка поиска, false - нажата кнопка "Загрузить еще"
    func fetchOfData(with text: String, searchButtonPressed: Bool, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        
        if searchButtonPressed == true {
            self.countOfRepeatLoad = 1
            self.text = text
            networkManager.getArrayOfImages(url: url, searchText: text, page: "0") { [weak self] result in
                let resulting: Result<Bool, Error>
                
                defer {
                    completion(resulting)
                }
                
                switch result {
                case .success(let arrayImages):
                    if !arrayImages.isEmpty {
                        self?.arrayOfImages = arrayImages
                        resulting = .success(false)
                    } else {
                        resulting = .success(true)
                    }
                case .failure(let error):
                    resulting = .failure(error)
                }
            }
        } else {
            networkManager.getArrayOfImages(url: url, searchText: self.text, page: String(countOfRepeatLoad)) { result in
                let resulting: Result<Bool, Error>
                
                defer {
                    completion(resulting)
                }
                
                switch result {
                case .success(let arrayImages):
                    if !arrayImages.isEmpty {
                        self.arrayOfImages.append(contentsOf: arrayImages)
                        resulting = .success(false)
                        self.countOfRepeatLoad += 1
                    } else {
                        resulting = .success(true)
                    }
                case .failure(let error):
                    resulting = .failure(error)
                }
            }
        }
    }
    
    
    func numberOfItemsInSection() -> Int {
        return arrayOfImages.count
    }
    
    /// Настройка ячейки CollectionView
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath) {
        guard let url = URL(string: arrayOfImages[indexPath.row]) else { return }
        DispatchQueue.main.async {
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: url, options: [.transition(.fade(0.4))]) { _ in }
        }
    }
}
