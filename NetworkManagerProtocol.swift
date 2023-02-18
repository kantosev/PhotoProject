//
//  NetworkManagerProtocol.swift
//  PetProject
//
//  Created by Ivan Eremeev on 19.11.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol {
    func getArrayOfImages(url: String,searchText: String, page: String?, completion: @escaping (([String], [String], [String]) -> ()), errorCompletion: @escaping (AFError) -> ())
    func getToDownloadLocation(indexPath: IndexPath)
}
