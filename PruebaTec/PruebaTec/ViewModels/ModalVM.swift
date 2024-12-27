//
//  ModalVM.swift
//  PruebaTec
//
//  Created by Leydidiana Osorio Domínguez on 24/12/24.
//

import Foundation

class ModalViewModel {
    var currentImageURL: String = ""
    
    func RandomImage(completion: @escaping (String?) -> Void) {
        APIService.shared.randomImage { result in
            switch result {
            case .success(let imageURL):
                self.currentImageURL = imageURL
                completion(imageURL)
            case .failure:
                completion(nil)
            }
        }
    }
}

