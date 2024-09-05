//
//  EmpiricalFormulaSolver.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import SwiftUI

/// Service that contains business logic to solve empirical formulas.
public struct EmpiricalFormulaSolver {

    /// Error thrown by the empirical formula solver.
    public enum SolverError: Error {
        case percentSumError
    }

    /// Object that stores a listing for the empirical formula.
    public struct EmpiricalFormulaComponent: Identifiable {
        public let id = UUID()
        public var element: Element?
        public var value: Double // in grams
        public var isPercent: Bool

        public init(element: Element? = nil, value: Double, isPercent: Bool) {
            self.element = element
            self.value = value
            self.isPercent = isPercent
        }
    }

    /// Calculates the empirical formula given the input of elements and values in grams.
    /// - Parameter input: List of empirical formula components.
    /// - Returns: Solved empirical formula.
    public static func findEmpiricalFormula(for input: [EmpiricalFormulaComponent]) throws -> String {
        // Stores the list of equations from the input.
        var equations = input
        // If percent, convert it to grams.
        let total = equations.map({ $0.value }).reduce(0, +)

        // Throw an error if the total does not sum to 100.
        if total != 100 {
            throw SolverError.percentSumError
        }

        // Step 1 : Divide by atomic mass of element
        for (index, element) in equations.enumerated() {
            equations[index].value /= element.element!.atomicMass
        }

        // Step 2: Calculate the smallest mole value.
        let smallest = equations.map({ $0.value }).sorted(by: <).first!

        // Step 3: Divide all values by smallest mole value.
        for index in equations.indices {
            equations[index].value /= smallest
        }

        // Step 4: Determine if value is within rounding range.
        for (index, element) in equations.enumerated() {
            let smallRoundBounds = Double(Int(element.value))
            let midRoundBounds = Double(smallRoundBounds) + 0.5
            let largeRoundBounds = Double(smallRoundBounds) + 1.0

            if element.value - smallRoundBounds < 0.1 {
                equations[index].value = smallRoundBounds
            } else if abs(element.value - midRoundBounds) < 0.1 {
                equations[index].value = midRoundBounds
            } else if largeRoundBounds - element.value < 0.1 {
                equations[index].value = largeRoundBounds
            }
        }

        // Step 5: Multiply numbers until all values are even
        var allEven = !equations.contains(where: { $0.value != Double(Int($0.value)) })

        var multiplyCounter = 2

        while !allEven {

            var newEquations = equations

            for (index, element) in newEquations.enumerated() {

                newEquations[index].value *= Double(multiplyCounter)

                let smallRoundBounds = Double(Int(newEquations[index].value))
                let largeRoundBounds = Double(smallRoundBounds) + 1.0

                if element.value != Double(Int(newEquations[index].value)) {
                    if newEquations[index].value - smallRoundBounds < 0.1 {
                        newEquations[index].value = smallRoundBounds
                    } else if largeRoundBounds - newEquations[index].value < 0.1 {
                        newEquations[index].value = largeRoundBounds
                    }
                }
            }

            // Check again

            let secondAllEvenFlag = !newEquations.contains(where: { $0.value != Double(Int($0.value)) })

            if secondAllEvenFlag {
                allEven = true
                equations = newEquations
            } else {
                multiplyCounter += 1
            }
        }

        // Collapse the results into a final formula.
        var solvedFormula = ""

        for item in equations {
            solvedFormula += item.element!.symbol
            solvedFormula += "_{\(Int(item.value))}"
        }

        // Return the final list of equations.
        return solvedFormula
    }
}
