//
//  NetworkError.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//



import Foundation

enum NetworkError: Error {
    case urlNotFound
    case dataCantParse
    case noDataFound
    case httpFailure
}
