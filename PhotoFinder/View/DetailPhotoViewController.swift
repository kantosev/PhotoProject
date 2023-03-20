//
//  DetailPhotoViewController.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 26.11.2022.
//

import UIKit


class DetailPhotoViewController: UIViewController {
    
 
    @IBOutlet weak var textView: UITextView!
    var image: UIImage?
    let fileManager = FileManager.default
    private var viewModel: DetailViewModelProtocol?
    var imageScrollView: ImageScrollView!
    
    @IBOutlet weak var shareActionButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        viewModel = DetailViewModel()
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        setupImageScrollView()
//        guard let userNames = userName else { return}
//        setTextViewHyperText(userName: userNames, longHyperText: userNames.count)
        
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
            AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Successfully", comment: "Successfully"), message: NSLocalizedString("Photo uploaded to gallery", comment: "Photo uploaded to gallery"))
        } errorCompletion: {
            AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error5"), message: NSLocalizedString("Loading error", comment: "Loading error"))
        }
    }
   
    func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        guard let image = image else { return }
        self.imageScrollView.set(image: image)
        
    }
}
