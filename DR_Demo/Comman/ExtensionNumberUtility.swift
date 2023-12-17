//
//  ExtensionNumberUtility.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 17/12/23.
//

import Foundation

extension Double {
    public func truncateZeros(digitsCountAfterDecimal: Int = 2) -> String? {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = digitsCountAfterDecimal
        return formatter.string(for: self)
    }
}
