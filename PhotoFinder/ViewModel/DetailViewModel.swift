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
    
    // Успешное сохранение
    var successCompletion: (() -> ())?
    // Ошибка
    var errorCompletion: (() -> ())?
    
    /// Сохранение изображения в галерею
    /// - Parameters:
    ///   - image: Сохраняемое иображение
    ///   - successCompletion: Успешно
    ///   - errorCompletion: Ошибка
    func saveImage(image: UIImage, successCompletion: @escaping () -> (), errorCompletion: @escaping () -> ()) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved), nil)
        self.successCompletion = successCompletion
        self.errorCompletion = errorCompletion
    }
    
    
    /// Необязательный #selector - для вызова completion
    /// - Parameters:
    ///   - image: Сохраняемое иображение
    ///   - error: Ошибка
    @objc private func imageSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
        if error != nil {
            errorCompletion?()
            return
        }
        successCompletion?()
    }
    
}
