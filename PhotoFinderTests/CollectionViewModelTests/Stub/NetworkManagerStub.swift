//
//  NetworkManagerStub.swift
//  PhotoFinderTests
//
//  Created by Anton Kirilyuk on 17.02.2024.
//

import Foundation
import Alamofire
@testable import PhotoFinder

class NetworkManagerStub: NetworkManagerProtocol {
    func getArrayOfImages(url: String,searchText: String, page: String?, completion: @escaping (Result<[String], Error>) -> Void) {
        completion(.success([]))
    }
}
