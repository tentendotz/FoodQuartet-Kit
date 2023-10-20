//
//  Endpoint.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/10/11.
//

import Foundation

struct Endpoint {
    
    private let host: Host
    private let path: String
    private let queryItems: [URLQueryItem]?
    
    /// Initializes the endpoint for a particular website using specified search terms.
    init(host: Host, components: [String]) {
        self.host = host
        self.path = host.buildPath(with: components)
        self.queryItems = host.buildQuery(with: components)
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host.rawValue
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}


extension Endpoint {
    
    // MARK: - URL Components Definition
    
    enum Host: String {
        /// https://www.google.com/search?q=queryItem
        case google = "www.google.com"
        /// https://www.foodnetwork.com/search/keywords-
        case foodNetwork = "www.foodnetwork.com"
        
        fileprivate func buildPath(with keywords: [String]) -> String {
            let search = "/search"
            
            switch self {
            case .google:
                return search
            case .foodNetwork:
                let segment = keywords.joined(separator: "-").appending("-")
                let searchDir = [search, segment].joined(separator: "/")
                return searchDir
            }
        }
        
        fileprivate func buildQuery(with keywords: [String]) -> [URLQueryItem]? {
            let base = [K.L10n.recipe] // Recipe
            let queryTerms = keywords.isEmpty ? base : base + keywords
            let queryString = queryTerms.joined(separator: "+")
            
            switch self {
            case .google:
                return [URLQueryItem(name: "q", value: queryString)]
            default:
                return nil
            }
        }
    }
}
