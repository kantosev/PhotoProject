//
//  NetworkManager.swift
//  PetProject
//
//  Created by Антон Кирилюк on 13.11.2022.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManagerProtocol {
    func getArrayOfImages(url: String, searchText: String, completion: @escaping (([String]) -> ()), errorCompletion: @escaping ((AFError) -> ())) {
        guard let url = URL(string: url) else { return }
        let urlParams = [
                "query": searchText,
                "per_page": "10"
            ]
        let headers = [
            "Authorization": "Client-ID 4Uitm6ZbRdgeZKMPHKFW11JI9Q00TFRFN3ajlRuzUTs"
        ]
        AF.request(url, parameters: urlParams, headers: HTTPHeaders(headers)).validate().responseDecodable(of: UnsplashImageModel.self) { response in
            switch response.result {
            case .success(let answer):
                var array: [String] = []
                #warning("Если всего есть меньше 10 фото, то краш")
                for image in 0...9 {
                    array.append(answer.results[image].urls.regular)
                }
                completion(array)
            case.failure(let error):
                print(error)
                errorCompletion(error)
            }
        }
    }
}
