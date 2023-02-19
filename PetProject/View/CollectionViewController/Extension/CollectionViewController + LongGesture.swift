//
//  CollectionViewController + LongGesture.swift
//  PetProject
//
//  Created by Антон Кирилюк on 19.02.2023.
//

import UIKit


extension CollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        let cell = collectionView.cellForItem(at: indexPaths[0]) as? PhotoCell
        let image = cell?.imageView.image
        self.image = image
        return UIContextMenuConfiguration(actionProvider:  { _ in
            self.imageMenu
        })
    }
    
    func setupImageMenu() {
        let shareImage = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { _ in
            let items: [Any] = [self.image as Any]
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            //        activityVC.modalPresentationStyle = .popover
            // для ipad -> указываем точку привязки для popover'a, причем строчка выше необязательна.
//            activityVC.popoverPresentationController?.barButtonItem = shareActionButton
            
            self.present(activityVC, animated: true)
        }
        let saveImage = UIAction(title: "Сохранить", image: UIImage(systemName: "tray.and.arrow.down")) { _ in
            guard let image = self.image else { return }
            self.detailViewModel?.saveImage(image: image, successCompletion: {
                AlertController.showAlertController(onViewController: self, title: "Успешно", message: "Фото загружено в галерею")
            }, errorCompletion: {
                AlertController.showAlertController(onViewController: self, title: "Ошибка", message: "Ошибка загрузки")
            })
        }
            
        imageMenu = UIMenu(title: "Options", children: [shareImage, saveImage])
    }
}
