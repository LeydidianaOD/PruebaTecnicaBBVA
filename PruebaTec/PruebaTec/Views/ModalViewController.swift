//
//  ModalViewController.swift
//  PruebaTec
//
//  Created by Leydidiana Osorio Domínguez on 24/12/24.
//

import UIKit

class ModalViewController: UIViewController {
    @IBOutlet weak var imageR: UIImageView!
    @IBOutlet weak var randomImgButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    private let viewModel = ModalViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomImgButton.layer.cornerRadius = 10
        randomImgButton.layer.masksToBounds = true
        logoutButton.layer.cornerRadius = 10
        logoutButton.layer.masksToBounds = true
        fetchNewImage()
    }
    
    private func fetchNewImage() {
        viewModel.RandomImage { [weak self] imageURL in
            guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }
            DispatchQueue.main.async {
                self?.imageR.load(url: url)
            }
        }
    }
    
    @IBAction func randomImageTapped(_ sender: Any) {
        fetchNewImage()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "loggedInUser")
        self.dismiss(animated: true)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}

