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
            "query": searchText,
            "per_page": "10",
            "page": page
        ]
        let headers = [
            "X-RapidAPI-Key": "a7e581eb9amsheeb72a6a4042d77p1db599jsn9b1afcde9cb1",
            "X-RapidAPI-Host": "unsplash-data.p.rapidapi.com"
        ]
        AF.request(url, parameters: urlParams, headers: HTTPHeaders(headers)).validate().responseDecodable(of: ImageModel.self) { response in
            switch response.result {
            case .success(let answer):
                UserDefaults.standard.setCodableObject(answer, forKey: "userModel")
                var arrayImagesUrl: [String] = []
                let imagesCount = answer.results.count
                
                guard let imageSize = UserDefaults.standard.string(forKey: "sizeImage"), !imageSize.isEmpty else { if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.regular!)
                    }
                }
                    return
                }
                switch imageSize {
                case "raw": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.raw!)
                       
                    }
                }
                case "full": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.full!)
                        
                    }
                }
                case "regular": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.regular!)
                        
                    }
                }
                case "small": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.small!)
                       
                    }
                }
                case "thumb": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.thumb!)
                    }
                }
                default: break 
                }
                
                
                completion(arrayImagesUrl)
            case.failure(let error):
                print(error)
                errorCompletion(error)
            }
        }
    }

}
