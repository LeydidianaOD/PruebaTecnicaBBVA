//
//  Toast.swift
//  PruebaTec
//
//  Created by Leydidiana Osorio Domínguez on 24/12/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let width = view.frame.width - 40
        toastLabel.frame = CGRect(x: 20, y: view.frame.height - 120, width: width, height: 50)
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
    
}
