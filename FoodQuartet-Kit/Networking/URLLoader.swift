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
            return K.L10n.error
        }
        
        var failureReason: String? {
            switch self {
            case .invalidURL:
                return K.L10n.googleFailed
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
