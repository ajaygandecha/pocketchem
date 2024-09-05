//
//  SignificantFigureCalculator.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data

/// Service that contains business logic to count the number of significant figures in a number.
public struct SignificantFigureCalculator {

    /// Error thrown by the significant figure calculator.
    public enum CalculationError: Error {
        case tooManyPeriods
        case containsNotAcceptedCharacters
        case unexpectedIssue
    }

    /// Solution given by the significant figure calculator.
    public struct Solution {
        /// Provided input that gave the solution.
        public var string: String
        /// Final number of calculated significant figures.
        public var numberOfSigFigs: Int
        /// Index locations of the significant figures in the `string` property.
        public var locationsOfSigFigs: Set<Int>
    }

    /// Calculates the number of significant figures in an input string.
    /// - Parameter inputString: String representing the typed number.
    /// - Returns: Solution containing the number and locations of significant figures.
    public static func calculateSignificantFigures(for inputString: String) throws -> Solution {

        // Throw an error if the input includes too many periods.
        if inputString.filter({ $0 == "." }).count > 1 {
            throw CalculationError.tooManyPeriods
        }
        // Throw an error if the input includes any other characters than numbers or periods.
        let acceptedCharacters: Set<Character> = Set(["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", ","])
        if inputString.contains(where: { !acceptedCharacters.contains($0) }) {
            throw CalculationError.containsNotAcceptedCharacters
        }

        // Process the string to remove any commas if included.
        let cleanedInputString = inputString.filter({ $0 != "," })

        // Define variables to store the solution.
        var locationsOfSigFigs: Set<Int> = Set()

        // Locate the decimal place in the string.
        let decimalPlaceLocation = cleanedInputString.firstIndex(of: ".")
        let decimalLocationExists = decimalPlaceLocation != nil

        // Check Rule 1: Every non-zero digit is a significant figure.
        for (index, character) in cleanedInputString.enumerated() where character.isNumber && character != "0" {
            locationsOfSigFigs.insert(index)
        }

        // Check Rule 4: All trailing zeroes after a decimal are significant figures.
        // Note: This only checks the last digit. If there is a trailing 0, then all
        // other zones will be a significant based on rule 2.
        if decimalLocationExists && cleanedInputString.last == "0" {
            locationsOfSigFigs.insert(cleanedInputString.count - 1)
        }

        // CHECK Rule 2a: All digits between significant figures are significant figures.
        // Note: This finds the leftmost and rightmost significant figure so far, then
        // marks any digits between these as significant figures. Note that if the
        // decimal place is to the right of the max significant figure, its location is
        // instead treated as the right bound for significant figures.
        let sortedLocationsOfSigFigs = Array(locationsOfSigFigs).sorted(by: <)
        let decimalLocationIndex = cleanedInputString.distance(
            from: cleanedInputString.startIndex,
            to: decimalPlaceLocation ?? cleanedInputString.startIndex
        )
        let minSignificantFigureIndex = sortedLocationsOfSigFigs.first!
        let maxSignificantFigureIndex = max(sortedLocationsOfSigFigs.last!, decimalLocationIndex)

        for digitIndex in minSignificantFigureIndex...maxSignificantFigureIndex {
            locationsOfSigFigs.insert(digitIndex)
        }

        // Finally, remove the decimal from the locations of sig figs, if included.
        if let location = decimalPlaceLocation {
            locationsOfSigFigs.remove(cleanedInputString.distance(from: cleanedInputString.startIndex, to: location))
        }

        // Return the result.
        return Solution(
            string: cleanedInputString,
            numberOfSigFigs: locationsOfSigFigs.count,
            locationsOfSigFigs: locationsOfSigFigs
        )
    }
}
