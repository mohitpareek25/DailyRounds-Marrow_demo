//
//  URLGenerator.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//


import Foundation

final class URLGenerator {
    static func prepareURL(_ api: APIRequest) -> URL? {
        var urlComponents = URLComponents(string: api.url.absoluteString)
        let queryItems = api.queryParams?.map({ (key, value) in
            return URLQueryItem(name: key, value: String(describing: value) )
        })
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    static func prepareURLRequest(with api: APIRequest) -> URLRequest? {
        guard let url = prepareURL(api) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.method.rawValue
        urlRequest.allHTTPHeaderFields = api.headers
        urlRequest.httpBody = api.body
        return urlRequest
    }
}
