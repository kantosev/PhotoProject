//
//  DetailViewModelProtocol.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 07.01.2023.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol {
    func saveImage(image: UIImage, successCompletion: @escaping () -> (), errorCompletion: @escaping () -> ())
}
