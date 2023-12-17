//
//  NetworkLayer.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//



import Foundation

protocol NetworkLayerServiceable {
    func dataTask<T: Codable>(_ api: APIRequest, completion: @escaping (_ result: Result<T, NetworkError>) -> Void)
}

final class NetworkLayerServices: NetworkLayerServiceable {
    let urlSession: URLSession
    private let configuration: URLSessionConfiguration
    
    init() {
        configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        
        urlSession = URLSession(configuration: configuration)
    }
}
