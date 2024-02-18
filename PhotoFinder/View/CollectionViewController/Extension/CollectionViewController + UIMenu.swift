//
//  CollectionViewController + LongGesture.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 19.02.2023.
//

import UIKit


extension CollectionViewController {
    
    /// Запрашивает у делегата конфигурацию меню для конкретной ячейки
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        if !indexPaths.isEmpty {
            let cell = collectionView.cellForItem(at: indexPaths[0]) as? PhotoCell
            let image = cell?.imageView.image
            self.image = image
            return UIContextMenuConfiguration(actionProvider:  { _ in
                self.imageMenu
            })
        } else {
            return nil
        }
    }
    
    /// Настройка меню
    func setupImageMenu() {
        // Share Button
        let shareImage = UIAction(title: NSLocalizedString("Share", comment: "MenuItemTitle"), image: UIImage(systemName: "square.and.arrow.up")) { _ in
            let items: [Any] = [self.image as Any]
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = CollectionViewHeader()
            
            self.present(activityVC, animated: true)
        }
        // Save Button
        let saveImage = UIAction(title: NSLocalizedString("Save", comment: "MenuItemTitle"), image: UIImage(systemName: "tray.and.arrow.down")) { _ in
            guard let image = self.image else { return }
            self.detailViewModel?.saveImage(image: image) { result in
                switch result {
                case .success(_):
                    AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Successfully", comment: "Successfully"), message: NSLocalizedString("Photo uploaded to gallery", comment: "Photo uploaded to gallery"))
                case .failure(let error as NSError):
                    // Нет доступа к галерее
                    if error.domain == "ALAssetsLibraryErrorDomain" {
                        AlertController.galleryAccessIsDenied(onViewController: self)
                    // Остальные ошибки
                    } else {
                        AlertController.showAlertController(onViewController: self, title: NSLocalizedString("Error", comment: "Error5"), message: NSLocalizedString("Loading error", comment: "Loading error"))
                        
                    }
                }
            }
        }
            
        imageMenu = UIMenu(title: NSLocalizedString("Options", comment: "MenuTitle"), children: [shareImage, saveImage])
    }
}
