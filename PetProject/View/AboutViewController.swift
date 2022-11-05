//
//  AboutViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 05.11.2022.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   

    
    @IBAction func logOutButtonAction(_ sender: Any) {
        SignManager.logOut(onViewController: self) {
            self.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

}
