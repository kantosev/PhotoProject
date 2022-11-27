//
//  DetailPhotoViewController.swift
//  PetProject
//
//  Created by Антон Кирилюк on 26.11.2022.
//

import UIKit


class DetailPhotoViewController: UIViewController {

    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        print(34)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
