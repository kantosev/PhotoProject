//
//  DetailViewModelProtocol.swift
//  PetProject
//
//  Created by Антон Кирилюк on 07.01.2023.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    func saveImage(image: UIImage, successCompletion: @escaping () -> (), errorCompletion: @escaping () -> ())
    
}
