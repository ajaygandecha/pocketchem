//
//  Double+Rounding.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Foundation

extension Double {

    /// Rounds a double.
    /// - Parameter places: Number of decimal places to round by.
    /// - Returns: Rounded number.
    public func rounded(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /// Rounds a double and truncates it as a string.
    /// - Parameter places: Number of decimal places to round by.
    /// - Returns: String that contains the rounded number.
    public func roundedString(to places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
