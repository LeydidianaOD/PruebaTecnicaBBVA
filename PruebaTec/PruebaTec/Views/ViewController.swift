//
//  ViewController.swift
//  PruebaTec
//
//  Created by Leydidiana Osorio Domínguez on 24/12/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPassword: UIView!
    
    private let viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        viewEmail.layer.cornerRadius = 10
        viewEmail.layer.borderWidth = 1
        viewEmail.layer.borderColor = UIColor.black.cgColor
        viewEmail.layer.masksToBounds = true
        viewPassword.layer.cornerRadius = 10
        viewPassword.layer.borderWidth = 1
        viewPassword.layer.borderColor = UIColor.black.cgColor
        viewPassword.layer.masksToBounds = true
        checkIfUserIsLoggedIn()
    }
    
    private func checkIfUserIsLoggedIn() {
        if let _ = UserDefaults.standard.data(forKey: "loggedInUser") {
            navigateToModal()
        }
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        viewModel.email = emailTxt.text!
        viewModel.password = passwordTxt.text!
        viewModel.login { [weak self] success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    self?.navigateToModal()
                } else {
                    self?.showToast(message: errorMessage ?? "Error")
                }
            }
        }
    }
    
    
    private func navigateToModal() {
        let storyboard = UIStoryboard(name: "StoryboardImage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        controller.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            controller.modalPresentationStyle = .fullScreen
        }
        self.present(controller, animated: true, completion: nil)
    }
}

