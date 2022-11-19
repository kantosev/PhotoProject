//
//  NetworkManager.swift
//  PetProject
//
//  Created by Антон Кирилюк on 13.11.2022.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManagerProtocol {
    func getArrayOfImages(url: String, searchText: String, completion: @escaping ([String]) -> ()) {
        guard let url = URL(string: url) else { return }
        let urlParams = [
                "q": searchText,
            ]
    
        AF.request(url, parameters: urlParams).validate().responseDecodable(of: ImageModel.self) { response in
            switch response.result {
            case .success(let answer):
                completion(answer.results)
            case.failure(let error):
                print(error)
            }
        }
    }
}
