//
//  APIRequest.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//



import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct APIRequest {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]?
    let queryParams: [String: Any]?
    let body: Data?
}
