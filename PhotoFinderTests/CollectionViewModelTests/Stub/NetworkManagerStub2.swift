//
//  NetworkManagerStub2.swift
//  PhotoFinderTests
//
//  Created by Anton Kirilyuk on 18.02.2024.
//

import Foundation
import Alamofire
@testable import PhotoFinder

class NetworkManagerStub2: NetworkManagerProtocol {
    func getArrayOfImages(url: String,searchText: String, page: String?, completion: @escaping (Result<[String], Error>) -> Void) {
        completion(.failure(AFError.sessionDeinitialized))
    }
}
