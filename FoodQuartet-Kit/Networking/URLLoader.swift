//
//  URLLoader.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/10/13.
//

import Foundation

struct URLLoader {
    
    enum LoaderError: LocalizedError {
        case invalidURL
        
        var errorDescription: String? {
            return "Error"
        }
        
        var failureReason: String? {
            switch self {
            case .invalidURL:
                return "Google search has failed. The input may contain invalid characters.\nPlease change your search terms and try again."
            }
        }
    }
    
    /// Requests the URL using the specified `Endpoint` and throws a specific error if the operation fails.
    func request(target: Endpoint) throws -> URL {
        guard let encodedURL = target.url else {
            throw LoaderError.invalidURL
        }
        print(encodedURL.description)
        return encodedURL
    }
}
