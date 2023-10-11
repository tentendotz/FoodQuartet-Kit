//
//  Endpoint.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/10/11.
//

import Foundation

struct Endpoint {
    
    let host: Host
    let path: String
    let queryItems: [URLQueryItem]?
    
    init(site: Host, searchTerms: [String]) {
        self.host = site
        self.path = site.buildPath(with: searchTerms)
        self.queryItems = site.buildQuery(with: searchTerms)
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
        
        func buildPath(with keywords: [String]) -> String {
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
        
        func buildQuery(with keywords: [String]) -> [URLQueryItem]? {
            let base = ["Recipe"]
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
