//
//  Servicio.swift
//  PruebaTec
//
//  Created by Leydidiana Osorio Domínguez on 24/12/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private let baseURL = "https://reqres.in/api"
    private let API = "https://dog.ceo/api/breeds/image/random"
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters = ["email": email, "password": password]
        print(parameters)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completion(.failure(NSError(domain: "InvalidParameters", code: 400, userInfo: nil)))
            return
        }
        
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print(error)
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 500, userInfo: nil)))
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
                print(user)
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        
        task.resume()
    }
    

    func randomImage(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: API) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "InvalidResponse", code: 500, userInfo: nil)))
                return
            }
            
            do {
                let responseApi = try JSONDecoder().decode(ResponseApi.self, from: data)
                completion(.success(responseApi.message))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

struct ResponseApi: Decodable {
    let message: String
}
