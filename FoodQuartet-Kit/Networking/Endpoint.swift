//
//  Endpoint.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/10/11.
//

import Foundation

struct Endpoint {
    
    let queryItems: [URLQueryItem]?
    
    init(searchTerms: [String]) {
        let base = ["Recipe"]
        let queryTerms = searchTerms.isEmpty ? base : base + searchTerms
        let queryString = queryTerms.joined(separator: "+")
        
        self.queryItems = [URLQueryItem(name: "q", value: queryString)]
    }

    // https://www.google.com/search?q=queryItem
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.google.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}
