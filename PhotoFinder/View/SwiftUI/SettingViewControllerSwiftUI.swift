//
//  AboutViewControllerSwiftUI.swift
//  PetProject
//
//  Created by Anton Kirilyuk on 17.12.2022.
//

import SwiftUI

/// Обертка для использования SwiftUI в UIKit проекте
final class SettingViewControllerSwiftUI: UIViewController {
    
    private let hostingViewController = UIHostingController(rootView: SettingView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addVC()
        setupConstraint()
    }
  
    
    private func setupConstraint() {
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func addVC() {
        addChild(hostingViewController)
        view.addSubview(hostingViewController.view)
    }
}
