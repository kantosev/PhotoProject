//
//  CollectionViewModelProtocol.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.11.2022.
//

import Foundation
import Alamofire

protocol CollectionViewModelProtocol {
    /// Получение массива ссылок на изображения
    /// - Parameters:
    ///   - text: Поисковый запрос
    ///   - completion: Результат запроса
    ///   - searchButtonPressed: true - нажата кнопка поиска, false - нажата кнопка "Загрузить еще"
    func fetchOfData(with text: String, searchButtonPressed: Bool, completion: @escaping (Result<Bool, Error>) -> Void)
    /// Количество item в CollectionView
    func numberOfItemsInSection() -> Int
    /// Настройка ячейки CollectionView
    func setOfCell(cell: PhotoCell, with indexPath: IndexPath)
    
}
