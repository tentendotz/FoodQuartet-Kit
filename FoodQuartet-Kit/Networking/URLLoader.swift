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
    
    /// Requests the encoded URL for the target using the specified search terms.
    func request(target: Endpoint.Host, searchTerms: [String]) throws -> URL {
        let endpoint = Endpoint(host: target, components: searchTerms)
        
        guard let encodedURL = endpoint.url else {
            throw LoaderError.invalidURL
        }
        print(encodedURL.description)
        return encodedURL
    }
}
