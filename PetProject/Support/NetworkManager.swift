//
//  NetworkManager.swift
//  PetProject
//
//  Created by Ivan Eremeev on 13.11.2022.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManagerProtocol {
    func getArrayOfImages(url: String, searchText: String, page: String?, completion: @escaping (([String], [String], [String]) -> ()), errorCompletion: @escaping ((AFError) -> ())) {
        guard let url = URL(string: url) else { return }
        let urlParams = [
            "query": searchText,
            "per_page": "2",
            "page": page
        ]
        let headers = [
            "Authorization": "Client-ID 4Uitm6ZbRdgeZKMPHKFW11JI9Q00TFRFN3ajlRuzUTs"
        ]
        AF.request(url, parameters: urlParams, headers: HTTPHeaders(headers)).validate().responseDecodable(of: UnsplashImageModel.self) { response in
            switch response.result {
            case .success(let answer):
                UserDefaults.standard.setCodableObject(answer, forKey: "userModel")
                var arrayOfUserProfiles: [String] = []
                var arrayImagesUrl: [String] = []
                var arrayOfUserName: [String] = []
                let imagesCount = answer.results.count
                
                if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayOfUserProfiles.append(answer.results[image].user?.links.linkUser ?? "https://unsplash.com")
                        arrayImagesUrl.append(answer.results[image].urls.regular)
                        arrayOfUserName.append(answer.results[image].user?.username ?? "nil")
                    }
                }
               
                completion(arrayImagesUrl, arrayOfUserName, arrayOfUserProfiles)
            case.failure(let error):
                print(error)
                errorCompletion(error)
            }
        }
    }
    func getToDownloadLocation(model: UnsplashImageModel) {
        let headers = [
            "Authorization": "Client-ID 4Uitm6ZbRdgeZKMPHKFW11JI9Q00TFRFN3ajlRuzUTs"
        ]
        let count = model.results.count
        if count > 0 {
            for i in 0...(count - 1) {
                guard let url = URL(string: model.results[i].links.download_location) else { return }
                AF.request(url, method: .get, headers: HTTPHeaders(headers)).validate().responseString { _ in }
            }
        }
        
    }
}
