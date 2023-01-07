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
    private var viewModel: DetailViewModelProtocol?
    
    
    @IBOutlet weak var shareActionButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModel()
        imageView.image = image
        
    }
    
// MARK: - IBAction -
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let image = image else { return }
        saveImage(image: image)
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let items: [Any] = [image as Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        //        activityVC.modalPresentationStyle = .popover
        // для ipad -> указываем точку привязки для popover'a, причем строчка выше необязательна.
        activityVC.popoverPresentationController?.barButtonItem = shareActionButton
        
        self.present(activityVC, animated: true)
        
    }
// MARK: - Functions -
    private func saveImage(image: UIImage) {
        viewModel?.saveImage(image: image) {
            AlertController.showAlertController(onViewController: self, title: "Успешно", message: "Фото загружено в галерею")
        } errorCompletion: {
            AlertController.showAlertController(onViewController: self, title: "Ошибка", message: "Ошибка загрузки")
        }
    }
    
    
    
}
