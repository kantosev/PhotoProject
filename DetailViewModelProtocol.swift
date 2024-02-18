//
//  DetailViewModelProtocol.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 07.01.2023.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    /// Сохранение изображения в галерею
    /// - Parameters:
    ///   - image: Сохраняемое иображение
    ///   - completion: Результат запроса
    func saveImage(image: UIImage, completion: @escaping (Result<Data?, Error>) -> Void)
}
