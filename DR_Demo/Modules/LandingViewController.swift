//
//  ViewController.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 15/12/23.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton! {
        didSet {
            loginBtn.layer.cornerRadius = 8
            loginBtn.layer.borderColor = UIColor.black.cgColor
            loginBtn.layer.borderWidth = 0.5
            
        }
    }
    
    @IBOutlet weak var signupBtn: UIButton! {
        didSet {
            signupBtn.layer.cornerRadius = 8
            signupBtn.layer.borderColor = UIColor.black.cgColor
            signupBtn.layer.borderWidth = 0.5
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnPressed(_ sender: UIButton) {
        let vc = MedBookListViewController(MedBookViewModel(networkLayer: NetworkLayerServices()))
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        let vc = MedBookListViewController(MedBookViewModel(networkLayer: NetworkLayerServices()))
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
}

