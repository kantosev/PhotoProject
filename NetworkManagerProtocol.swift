//
//  NetworkManagerProtocol.swift
//  PetProject
//
//  Created by Антон Кирилюк on 19.11.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func getArrayOfImages(url: String, completion: @escaping ([String]) -> ())
}
