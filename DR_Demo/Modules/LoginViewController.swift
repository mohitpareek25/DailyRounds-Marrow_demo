//
//  ViewController.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 15/12/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var letsgoBtn: UIButton! {
        didSet {
            letsgoBtn.layer.cornerRadius = 8
            letsgoBtn.layer.borderColor = UIColor.black.cgColor
            letsgoBtn.layer.borderWidth = 0.5
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func letsGoBtnPressed(_ sender: UIButton) {
        let vc = MedBookListViewController(MedBookViewModel(networkLayer: NetworkLayerServices()))
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
}

