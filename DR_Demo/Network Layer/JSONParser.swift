//
//  JSONParser.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//


import Foundation

public class JSONParser {
    private let jsonDecoder = JSONDecoder()
    
    func decode<T: Codable>(_ data: Data) -> T? {
        return try? jsonDecoder.decode(T.self, from: data)
    }
}
