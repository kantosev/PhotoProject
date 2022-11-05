//
//  MainViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 03.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    var user: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
 
}
