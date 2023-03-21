//
//  NetworkManager.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 13.11.2022.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManagerProtocol {
    func getArrayOfImages(url: String, searchText: String, page: String?, completion: @escaping (([String]) -> ()), errorCompletion: @escaping ((AFError) -> ())) {
        guard let url = URL(string: url) else { return }
        let urlParams = [
            "q": searchText,
//            "page": page,
            "q_type": "jpg",
            "q_size_px": "med"
        ]
        let headers = [
            "Authorization": "Client-ID 65ad3ec70fa68e0",
        ]

        AF.request(url, parameters: urlParams, headers: HTTPHeaders(headers)).validate().responseDecodable(of: ImageModel.self) { response in
            switch response.result {
            case .success(let answer):
                UserDefaults.standard.setCodableObject(answer, forKey: "userModel")
                var arrayImagesUrl: [String] = []
                // В ответе от imgurAPI в массиве images может содержаться несколько фотографий ( т.е. в галерее может быть не одна фото).
                // В строчках ниже проверяется наличие нескольких фотографий и если так и есть, то они тоже добавляются в массив для последующей загрузки
                let imagesCount = answer.data.count
                
                if imagesCount > 1 {
                    for image1 in 0...(imagesCount - 1) {
                        guard let imageCount = answer.data[image1].images?.count else { return }
                        if imageCount > 1 {
                            for image2 in 0...(imageCount - 1) {
                                arrayImagesUrl.append(answer.data[image1].images?[image2].link ?? "")
                            }
                        } else {
                            arrayImagesUrl.append(answer.data[image1].images?[0].link ?? "")
                        }
                    }
                }
                completion(arrayImagesUrl)
            case.failure(let error):
                print(error)
                errorCompletion(error)
            }
        }
    }

}
