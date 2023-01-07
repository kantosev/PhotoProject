//
//  DetailViewModel.swift
//  PetProject
//
//  Created by Антон Кирилюк on 07.01.2023.
//

import Foundation
import UIKit


class DetailViewModel: NSObject, DetailViewModelProtocol {
    
    var successCompletion: (() -> ())?
    var errorCompletion: (() -> ())?
    
    func saveImage(image: UIImage, successCompletion: @escaping () -> (), errorCompletion: @escaping () -> ()) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved), nil)
        self.successCompletion = successCompletion
        self.errorCompletion = errorCompletion
    }
    
    @objc func imageSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
        if let error {
            print(error)
            errorCompletion?()
            return
        }
        successCompletion?()
        
    }
}
