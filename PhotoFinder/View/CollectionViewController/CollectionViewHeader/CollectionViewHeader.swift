//
//  CollectionViewHeader.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.11.2022.
//

import UIKit

/// Объект для поиска изображений (TextField + Search Button)
final class CollectionViewHeader: UICollectionReusableView {

    // MARK: - Properties

    @IBOutlet weak var searchTextField: UITextField!
    /// Поисковый запрос
    var searchText: String?
    
    // Индикатор загрузки
    var activityIndicator: UIActivityIndicatorView!
    
    private var notificationCenter: NotificationCenter!

    // MARK: - init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextField()
        setActivityIndicator()
        notificationCenter = NotificationCenter.default
        addObserverForOverButtonLoadPressed()
        addObserverForStopActivityIndicator()
    }
    
    // MARK: - IB
    
    /// Нажатие кнопки поиска
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let searchText = searchTextField.text, !searchText.isEmpty else { return notificationCenter.post(name: .init("errorSearch"), object: self, userInfo: nil) }
        let userInfo: [AnyHashable: Any] = ["text": searchText]
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        notificationCenter.post(name: .init("searchButtonPressed"), object: self, userInfo: userInfo)
    }
    

    
    // MARK: - Private func
    
    /// Настройка Text field
    private func setTextField() {
        searchTextField.placeholder = NSLocalizedString("Search image", comment: "Header placeholder")
        self.searchTextField.delegate = self
        // кнопка ввод скрыта до ввода первого символа
        searchTextField.enablesReturnKeyAutomatically = true
    }
    
    /// Настройка Activity Indicator
    private func setActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Observers
    
    /// Добавление наблюдателя за нажатием кнопки "Загрузить еще"
    private func addObserverForOverButtonLoadPressed() {
        notificationCenter.addObserver(self, selector: #selector(overButtonLoadPressed), name: .init("overImageLoad"), object: nil)
    }
    
    /// Нажата кнопка "Загрузить еще"
    @objc private func overButtonLoadPressed() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    /// Добавление наблюдателя за концом поиска (Остановка Activity indicator)
    private func addObserverForStopActivityIndicator() {
        notificationCenter.addObserver(self, selector: #selector(stopActivityIndicator), name: .init("stopActivityIndicator"), object: nil)
    }
    
    /// Остановка Activity indicator
    @objc private func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}

