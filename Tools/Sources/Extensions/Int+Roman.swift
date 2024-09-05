//
//  Int+Roman.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Foundation

extension Int {

    /// Representation of the number as roman numerals in string format.
    public var romanNumeral: String {
        var integerValue = self
        // Roman numerals cannot be represented in integers greater than 3999
        if self >= 4000 {
            return "Invalid input (greater than 3999)"
        }
        var numeralString = ""
        let mappingList: [(Int, String)] = [
            (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
            (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
        ]
        for item in mappingList {
            while integerValue >= item.0 {
                integerValue -= item.0
                numeralString += item.1
            }
        }
        return numeralString
    }
}
