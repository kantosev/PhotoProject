//
//  UnsplashImageModel.swift
//  PetProject
//
//  Created by Антон Кирилюк on 27.11.2022.
//

import Foundation

struct UnsplashImageModel: Codable {
    let results: [Result]
}

struct Result: Codable {
    let urls: Urls
}
struct Urls: Codable {
    let small: String
}
