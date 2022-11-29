//
//  DetailPhotoViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 26.11.2022.
//

import UIKit


class DetailPhotoViewController: UIViewController {

    var image: UIImage?
    let fileManager = FileManager.default
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        print(image?.description)
    }
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let image = image else { return }
        saveImage(image: image)
    }
    
    private func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageDidSaved), nil)
    }
    @objc private func imageDidSaved(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
        if let error {
            print(error)
            AlertController.showAlertController(onViewController: self, title: "Ошибка", message: "Ошибка загрузки")
            return
        }
        AlertController.showAlertController(onViewController: self, title: "Успешно", message: "Фото загружено в галерею")
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let items: [Any] = [image as Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    
}
