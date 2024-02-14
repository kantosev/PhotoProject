//
//  NetworkManager.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 13.11.2022.
//

import Foundation
import Alamofire

/// Manager для работы с сетью (загрузка изображений)
final class NetworkManager: NetworkManagerProtocol {
    
    /// Загрузка массива ссылок на изображения
    /// - Parameters:
    ///   - url: Ссылка для загрузки
    ///   - searchText: Текст запроса
    ///   - page: Номер страницы для загрузки
    ///   - completion: После успешной загрузки
    ///   - errorCompletion: При ошибке
    func getArrayOfImages(url: String, searchText: String, page: String?, completion: @escaping (([String]) -> ()), errorCompletion: @escaping ((AFError) -> ())) {
        guard let url = URL(string: url) else { return }
        
        var sizeOfImage = UserDefaults.standard.string(forKey: "sizeImage")
        switch sizeOfImage {
        case "1": sizeOfImage = "small"
        case "2": sizeOfImage = "med"
        case "3": sizeOfImage = "big"
        case "4": sizeOfImage = "lrg"
        default: break
        }
        
        let urlParams = [
            "q": searchText,
            "page": page,
            "q_type": "jpg",
            "q_size_px": sizeOfImage ?? "med"
        ]
        let headers = [
            "Authorization": "Client-ID 65ad3ec70fa68e0"
        ]
        
        // Alamofire - непосредственно получение данных
        AF.request(url, parameters: urlParams, headers: HTTPHeaders(headers)).responseDecodable(of: ImageModel.self) { response in
            switch response.result {
            case .success(let answer):
                var arrayImagesUrl: [String] = []
                let imagesCount = answer.data.count
                
                if imagesCount > 0 {
                    for image in 0...(imagesCount - 1) {
                        if answer.data[image].images?[0].type == "image/jpeg" {
                            arrayImagesUrl.append(answer.data[image].images?[0].link ?? "")
                        }
                    }
                }
                completion(arrayImagesUrl)
            case.failure(let error):
                errorCompletion(error)
            }
        }
    }
    
}
