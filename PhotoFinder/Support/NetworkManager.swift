//
//  NetworkManager.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 13.11.2022.
//

import Foundation
import Alamofire

class NetworkManager: NetworkManagerProtocol {
    func getArrayOfImages(url: String, searchText: String, page: String?, completion: @escaping (([String], [String], [String]) -> ()), errorCompletion: @escaping ((AFError) -> ())) {
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
        AF.request(url, parameters: urlParams, headers: HTTPHeaders(headers)).validate().responseDecodable(of: UnsplashImageModel.self) { response in
            switch response.result {
            case .success(let answer):
                UserDefaults.standard.setCodableObject(answer, forKey: "userModel")
                var arrayImagesUrl: [String] = []
                var arrayOfUserName: [String] = []
                var arrayDownloadLocation: [String] = []
                let imagesCount = answer.results.count
                
                guard let imageSize = UserDefaults.standard.string(forKey: "sizeImage"), !imageSize.isEmpty else { if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.regular!)
                        arrayOfUserName.append(answer.results[image].user?.username ?? "nil")
                        arrayDownloadLocation.append(answer.results[image].links.download_location)
                    }
                }
                    return
                }
                switch imageSize {
                case "raw": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.raw!)
                        arrayOfUserName.append(answer.results[image].user?.username ?? "nil")
                        arrayDownloadLocation.append(answer.results[image].links.download_location)
                    }
                }
                case "full": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.full!)
                        arrayOfUserName.append(answer.results[image].user?.username ?? "nil")
                        arrayDownloadLocation.append(answer.results[image].links.download_location)
                    }
                }
                case "regular": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.regular!)
                        arrayOfUserName.append(answer.results[image].user?.username ?? "nil")
                        arrayDownloadLocation.append(answer.results[image].links.download_location)
                    }
                }
                case "small": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.small!)
                        arrayOfUserName.append(answer.results[image].user?.username ?? "nil")
                        arrayDownloadLocation.append(answer.results[image].links.download_location)
                    }
                }
                case "thumb": if imagesCount > 1 {
                    for image in 0...(imagesCount - 1) {
                        arrayImagesUrl.append(answer.results[image].urls.thumb!)
                        arrayOfUserName.append(answer.results[image].user?.username ?? "nil")
                        arrayDownloadLocation.append(answer.results[image].links.download_location)
                    }
                }
                default: break 
                }
                
                
                completion(arrayImagesUrl, arrayOfUserName, arrayDownloadLocation)
            case.failure(let error):
                print(error)
                errorCompletion(error)
            }
        }
    }
//    func getToDownloadLocation(indexPath: IndexPath) {
//        guard let arrayDL = UserDefaults.standard.stringArray(forKey: "downloadLocation") else { return }
//        let headers = [
//            "X-RapidAPI-Key": "a7e581eb9amsheeb72a6a4042d77p1db599jsn9b1afcde9cb1",
//            "X-RapidAPI-Host": "unsplash-data.p.rapidapi.com"
//        ]
//        guard let url = URL(string: arrayDL[indexPath.row]) else { return }
//        AF.request(url, method: .get, headers: HTTPHeaders(headers)).validate().responseString { _ in }
//
//    }
}
