//
//  DetailViewModel.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 07.01.2023.
//

import Foundation
import UIKit

/// View model детального просмотра изображения
final class DetailViewModel: NSObject, DetailViewModelProtocol {
    
    var completion: ((Result<Data?, Error>) -> Void)?
    
    
    /// Сохранение изображения в галерею
    /// - Parameters:
    ///   - image: Сохраняемое иображение
    ///   - completion: Результат запроса
    func saveImage(image: UIImage, completion: @escaping (Result<Data?, Error>) -> Void) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved), nil)
        self.completion = completion
    }
    
    
    /// Необязательный #selector - для вызова completion
    /// - Parameters:
    ///   - image: Сохраняемое иображение
    ///   - error: Ошибка
    @objc private func imageSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
        let result: Result<Data?, Error>
        
        defer {
            completion?(result)
        }
        
        if let error {
            result = .failure(error)
            return
        }
        result = .success(nil)
    }
    
}
