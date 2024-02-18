//
//  NetworkManagerStub.swift
//  PhotoFinderTests
//
//  Created by Аркадий Варежкин on 17.02.2024.
//

import Foundation
import Alamofire
@testable import PhotoFinder

class NetworkManagerStub: NetworkManagerProtocol {
    func getArrayOfImages(url: String, searchText: String, page: String?, completion: @escaping (([String]) -> ()), errorCompletion: @escaping (Alamofire.AFError) -> ()) {
        completion([])
        errorCompletion(AFError.sessionDeinitialized)
    }
    
    
}
