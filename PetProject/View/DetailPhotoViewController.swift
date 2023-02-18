//
//  DetailPhotoViewController.swift
//  PetProject
//
//  Created by Ivan Eremeev on 26.11.2022.
//

import UIKit


class DetailPhotoViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var image: UIImage?
    let fileManager = FileManager.default
    private var viewModel: DetailViewModelProtocol?
    var imageScrollView: ImageScrollView!
    var userName: String?
    var url: String?
    
    @IBOutlet weak var shareActionButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModel()
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.addSubview(imageScrollView)
        setupImageScrollView()
        guard let userName = userName, let url = url else { return }
        setTextViewHyperText(userName: userName, url: url, longHyperText: userName.count)
        
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
   
    func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        guard let image = image else { return }
        self.imageScrollView.set(image: image)
        
    }
    func setTextViewHyperText(userName: String, url: String, longHyperText: Int) {
        let attributedString = NSMutableAttributedString(string: "Photo by \(userName) on Unsplash")
        guard let url = URL(string: url) else { return }
        let startIndex = userName.startIndex
        let endIndex = userName.endIndex
        let long = userName.distance(from: startIndex, to: endIndex)
        // Set the 'click here' substring to be the link
        attributedString.setAttributes([.link: url], range: NSMakeRange(9, long))

        self.textView.attributedText = attributedString
        self.textView.isUserInteractionEnabled = true
        self.textView.isEditable = false

        // Set how links should appear: blue and underlined
        self.textView.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }
    
    
}
