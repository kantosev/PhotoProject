//
//  NetworkManagerProtocol.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.11.2022.
//

import Foundation
import Alamofire



protocol NetworkManagerProtocol {
    
    /// Загрузка массива ссылок на изображения
    /// - Parameters:
    ///   - url: Ссылка для загрузки
    ///   - searchText: Текст запроса
    ///   - page: Номер страницы для загрузки
    ///   - completion: Результат запроса
    func getArrayOfImages(url: String,searchText: String, page: String?, completion: @escaping (Result<[String], Error>) -> Void)
}
