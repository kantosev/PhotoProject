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
            "per_page": "30"
        ]
        let headers = [
            "Authorization": "Client-ID 4Uitm6ZbRdgeZKMPHKFW11JI9Q00TFRFN3ajlRuzUTs"
        ]
        AF.request(url, parameters: urlParams, headers: HTTPHeaders(headers)).validate().responseDecodable(of: UnsplashImageModel.self) { response in
            switch response.result {
            case .success(let answer):
                var array: [String] = []
                
                let imagesCount = answer.results.count
                
                if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        array.append(answer.results[image].urls.regular)
                    }
                }
                completion(array)  
            case.failure(let error):
                print(error)
                errorCompletion(error)
            }
        }
    }
}
