//
//  DetailPhotoViewController.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 26.11.2022.
//

import UIKit

/// Экран детального просмотра изображения
final class DetailPhotoViewController: UIViewController {
    
    /// Открытое изображение
    var image: UIImage?
    /// File Manager
    let fileManager: FileManager
    /// View Model
    private let viewModel: DetailViewModelProtocol
    /// Для зума изображения
    var imageScrollView: ImageScrollView!
    /// Кнопка поделиться
    @IBOutlet weak var shareActionButton: UIBarButtonItem!
    
    // MARK: - init
    
    required init?(coder: NSCoder) {
        self.fileManager = FileManager.default
        self.viewModel = DetailViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageScrollView()
    }
    
// MARK: - IBAction
    
    /// Нажатие кнопки сохранения изображения
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let image = image else { return }
        localSaveImage(image: image)
        
    }
    /// Нажатие кнопки поделиться
    @IBAction func shareAction(_ sender: Any) {
        let items: [Any] = [image as Any]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // для ipad -> указываем точку привязки для popover'a
        activityVC.popoverPresentationController?.barButtonItem = shareActionButton
        
        self.present(activityVC, animated: true)
        
    }
// MARK: - Functions -
    
    /// Сохранение изображения
    private func localSaveImage(image: UIImage) {
        viewModel.saveImage(image: image) { result in
            switch result {
            case .success(_):
                AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Successfully", comment: "Successfully"), message: NSLocalizedString("Photo uploaded to gallery", comment: "Photo uploaded to gallery"))
            case .failure(_):
                AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error5"), message: NSLocalizedString("Loading error", comment: "Loading error"))
            }
        }
    }
    
    /// Настройка ScrollView (for Zoom)
    private func setupImageScrollView() {
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        guard let image = image else { return }
        self.imageScrollView.set(image: image)
        
    }
}
