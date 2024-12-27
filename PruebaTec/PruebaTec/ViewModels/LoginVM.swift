//
//  LoginVM.swift
//  PruebaTec
//
//  Created by Leydidiana Osorio Domínguez on 24/12/24.
//

import Foundation

class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    func login(completion: @escaping (Bool, String?) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            completion(false, "Por favor, llena todos los campos")
            return
        }
        
        APIService.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                if let data = try? JSONEncoder().encode(user) {
                    UserDefaults.standard.set(data, forKey: "loggedInUser")
                }
                completion(true, nil)
            case .failure:
                completion(false, "No se puede iniciar sesión")
            }
        }
    }
}

