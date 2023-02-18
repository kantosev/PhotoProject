//
//  DetailViewModelProtocol.swift
//  PetProject
//
//  Created by Ivan Eremeev on 07.01.2023.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    func saveImage(image: UIImage, successCompletion: @escaping () -> (), errorCompletion: @escaping () -> ())
    
    
}
