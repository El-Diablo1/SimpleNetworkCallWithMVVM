//
//  NetworkManager.swift
//  Simple Network  Call With MVVM
//
//  Created by Ale on 23/08/2023.
//

import UIKit
import Foundation

class NetworkManager{
    
    //MARK: - Properties
    static var shared = NetworkManager()
    
    //MARK: - Method
    func fetchData<T: Decodable>(for: T.Type, from urlString: String) async throws -> T{
        
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURLString }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch{
            throw NetworkError.invalidData
        }
    }
}

enum NetworkError: Error{
    case invalidResponse
    case invalidData
    case invalidURLString
}
