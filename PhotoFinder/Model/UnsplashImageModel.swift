//
//  UnsplashImageModel.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 27.11.2022.
//

import Foundation

struct UnsplashImageModel: Codable {
    let results: [Result]
}
struct Result: Codable {
    let urls: Urls
    let links: Links
    let user: UserUnsplash?
}
struct Urls: Codable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?

}
struct Links: Codable {
    let download_location: String
}
struct UserUnsplash: Codable {
    let username: String
}

