//
//  Endpoint.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/10/11.
//

import Foundation

struct Endpoint {
    
    let host: Host
    let queryItems: [URLQueryItem]?
    
    init(site: Host, searchTerms: [String]) {
        self.host = site
        self.queryItems = site.buildQuery(with: searchTerms)
    }

    // https://www.google.com/search?q=queryItem
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host.rawValue
        urlComponents.path = "/search"
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}


extension Endpoint {
    
    enum Host: String {
        case google = "www.google.com"
        
        func buildQuery(with keywords: [String]) -> [URLQueryItem]? {
            let base = ["Recipe"]
            let queryTerms = keywords.isEmpty ? base : base + keywords
            let queryString = queryTerms.joined(separator: "+")
            
            switch self {
            case .google:
                return [URLQueryItem(name: "q", value: queryString)]
            }
        }
    }
}
