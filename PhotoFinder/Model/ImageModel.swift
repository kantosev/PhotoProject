//
//  UnsplashImageModel.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 27.11.2022.
//

import Foundation

/// Модель изображения, загружаемого из сети
struct ImageModel: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let images: [Image]?
}

// MARK: - Image
struct Image: Codable {
    let type: String
    let link: String
}

