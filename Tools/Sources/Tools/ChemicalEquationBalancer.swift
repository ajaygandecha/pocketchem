//
//  ChemicalEquationBalancer.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data

/// Service that contains business logic to balance chemical equations.
public struct ChemicalEquationBalancer {

    /// Error thrown by the chemical equation balancer.
    public enum BalanceError: Error {
        case inputError
        case nonNormalDelimiterError
        case missingReactantsOrProducts
        case unbalancedError
        case noAnswerError
    }

    /// Balances a chemical equation given reactants and products in string format.
    ///
    /// This algorithm utilizes linear algebra techniques to balance chemical equations.
    ///
    /// - Parameters:
    ///   - reactants: List of reactants.
    ///   - products: List of products.
    /// - Returns: Returns a string representation of the balanced chemical equation.
    public static func balanceChemicalEquation(
        reactants reactantInput: String,
        products productInput: String
    ) throws -> String {

        // Remove any whitespace
        let rawReactantInput = reactantInput.replacingOccurrences(of: " ", with: "")
        let rawProductInput = productInput.replacingOccurrences(of: " ", with: "")

        // Split string at + sign
        let reactants = rawReactantInput.components(separatedBy: "+")
        let products = rawProductInput.components(separatedBy: "+")

        // Validate inputs

        // Throw an error if reactants or products are missing.
        if reactantInput.count == 0 || reactants.count == 0 || productInput.count == 0 || products.count == 0 {
            throw BalanceError.missingReactantsOrProducts
        }

        // Throw an error if either the reactants or products include a
        // non-normal delimiter or if the input provided is invalid.
        for reactant in reactants {
            if reactant.contains("[") || reactant.contains("]") || reactant.contains("{") || reactant.contains("}") ||
                reactant.contains("<") || reactant.contains(">") {
                throw BalanceError.nonNormalDelimiterError
            }
            if reactant == "" || (reactant.containsSpecialCharacter && reactant.contains("(") == false &&
                reactant.contains(")") == false) || reactant == "+" || reactant == "-" || reactant == "_" {
                throw BalanceError.inputError
            }
        }
        for product in products {
            if product.contains("[") || product.contains("]") || product.contains("{") || product.contains("}") ||
                product.contains("<") || product.contains(">") {
                throw BalanceError.nonNormalDelimiterError
            }
            if product == "" || (product.containsSpecialCharacter && product.contains("(") == false &&
                product.contains(")") == false) || product == "+" || product == "-" || product == "_" {
                throw BalanceError.inputError
            }
        }

        // Execute Main Algorithm

        // Calculate coefficients for each element to use in the matrix.
        var coefficients: [String: Double] = [:]

        for index in reactants.indices {
            coefficients["a\(index + 1)"] = -1 // -1 means not solved for yet

        }
        for index in products.indices {
            coefficients["a\(reactants.count + index + 1)"] = -1 // -1 means not solved for yet
        }

        // Create a linear equation for each element to use in in the matrix.

        // Store linear equations for each element, there the key is the element.
        var equations: [String: (reactantSide: [String], productSide: [String])] = [:]

        // Parse reactants and append data to equations.
        var reactantElements: [String] = []
        for (index, reactant) in reactants.enumerated() {

            let reactantData = ChemistryParser.elementsAndNumbersFromCompound(from: reactant)

            for (element, number) in reactantData {
                reactantElements.append(element)
                if equations.keys.contains(element) {
                    equations[element]?.reactantSide.append("\(number)a\(index + 1)")
                } else {
                    equations[element] = (reactantSide: ["\(number)a\(index + 1)"], productSide: [])
                }
            }
        }

        // Parse products and append data to equations.
        for (index, product) in products.enumerated() {
            let productData = ChemistryParser.elementsAndNumbersFromCompound(from: product)
            for (element, number) in productData {

                // Throw an error if an element found in the product side is not found
                // on the reactant side.
                if !reactantElements.contains(element) {
                    throw BalanceError.unbalancedError
                }

                equations[element]?.productSide.append("\(number)a\(reactants.count + index + 1)")
            }
        }

        // Remove any blank items from the equation, if any.
        if equations.keys.contains("") {
            equations.removeValue(forKey: "")
        }

        // Generate a matrix with the given equations.
        let equationMatrix = generateMatrixFromEquations(equations: equations)

        // Compute the reduced-row echelon form of the equation matrix to solve
        // the linear equations. This final matrix will include the ratios that
        // map to the final coefficients for the balanced chemical equation.
        let rrefEquationMatrix = Math.rref(equationMatrix)

        // Calculate the final coefficients from the solved matrix.
        var finalCoefficients: [Int]! = []

        do {
            finalCoefficients = try getCoefficientsFromRrefMatrix(
                rrefMatrix: rrefEquationMatrix,
                numCoeffs: rrefEquationMatrix[0].count - 1
            )
        } catch {
            finalCoefficients = []
        }

        // If the final coefficients array is empty, that means there was no
        // solution to the linear equation. So, throw an error.
        if finalCoefficients.isEmpty {
            throw BalanceError.noAnswerError
        }

        // Generate final simplified equation in string format.
        var attributes: [(index: Int, length: Int)] = []

        var finalString = ""
        for (index, reactant) in reactants.enumerated() {
            attributes.append((index: finalString.count, length: String(finalCoefficients[index]).count))
            finalString += "\(finalCoefficients[index])\(reactant) + "
        }

        finalString = finalString.dropLast(2) + "= "

        for (index, finalCoeff) in finalCoefficients[reactants.count...].enumerated() {
            attributes.append((index: finalString.count, length: String(finalCoeff).count))
            finalString += "\(finalCoeff)\(products[index]) + "
        }

        finalString = String(finalString.dropLast(2))

        // Return the final simplified balanced chemical equation.
        return finalString.trimmingCharacters(in: .whitespaces)
    }

    /// Generates a matrix from the given linear equations.
    /// - Parameter equations: Equations for the reactant side and product side of each element.
    /// - Returns: System of linear equations represented in matrix form.
    private static func generateMatrixFromEquations(
        equations: [String: (reactantSide: [String], productSide: [String])]
    ) -> Math.Matrix {

        var matrix: Math.Matrix = []

        // Generate a row in the matrix

        for (_, expression) in equations {

            var matrixRow: [Double] = []

            var currentVariableIndex = 1

            for item in expression.reactantSide + expression.productSide {

                let coefficient = Int(item.split(separator: "a")[0])
                let variableIndex = Int(item.split(separator: "a")[1])

                // Fill in 0s for spaces skipped
                let spacesSkipped = variableIndex! - currentVariableIndex

                for _ in 0..<spacesSkipped {
                    matrixRow.append(0)
                }

                // Fill in value
                if expression.reactantSide.contains(item) {
                    matrixRow.append(Double(coefficient!))
                } else {
                    matrixRow.append(0 - Double(coefficient!))
                }

                // Increment current var index
                currentVariableIndex = variableIndex! + 1
            }

            // Add the new matrix row to the matrix.
            matrix.append(matrixRow)
        }

        // Now add trailing 0s if matrix is not uniform

        var maxCols = -1

        for row in matrix where row.count > maxCols {
            maxCols = row.count
        }

        for (index, row) in matrix.enumerated() {

            var newRow = row
            while newRow.count < maxCols {
                newRow.append(0)
            }

            matrix[index] = newRow
        }

        // Add a column of 0s at the end

        for (index, row) in matrix.enumerated() {

            var newRow = row
            newRow.append(0)
            matrix[index] = newRow
        }

        return matrix
    }

    /// Calculates the correct whole number coefficients from the solved system of equations.
    ///
    /// Since the coefficients from the solved system of equations are in decimal format by default, this
    /// function first approximates each decimal as its nearest fraction (with a whole number numerator and
    /// a whole number denominator). Then, the fractions are multiplied by the least common multiple
    /// so that all fraction coefficients turn into integer whole numbers. Finally, the whole numbers are then
    /// simplified by dividing each by the greatest common factor.
    ///
    /// - Parameters:
    ///   - rrefMatrix: Matrix in reduced row echelon form (solved system of linear equations)
    ///   - numCoeffs: Number of coefficients.
    /// - Returns: Whole number coefficients from the solved matrix.
    private static func getCoefficientsFromRrefMatrix(rrefMatrix: Math.Matrix, numCoeffs: Int) throws -> [Int] {

        // Create an empty matrix.
        var matrix: Math.Matrix = []

        // Remove rows of all 0s.
        for row in rrefMatrix where row.contains(where: { $0 != 0.0 }) {
            matrix.append(row)
        }

        // Create a list to store rational versions of each coefficient.
        var coefficients: [Math.Rational] = []

        // Get fractions out of second to last column of matrix.
        for row in matrix {
            let decimal = abs(row[row.count - 2])

            // Convert the decimal coefficient to its fractional approximation.
            coefficients.append(Math.rationalApproximation(of: decimal))
        }

        // Find the least common multiple of each fraction.
        var lcm = 1

        for coeff in coefficients {
            lcm *= coeff.denominator
        }

        // Multiply all fractions by the least common multiple.
        var newCoefficients: [Int] = []

        for coeff in coefficients {
            let newNumber = Double(coeff.numerator * lcm) / Double(coeff.denominator)
            newCoefficients.append(Int(newNumber))
        }

        // Make the remaining missing values as the least common multiple.
        while newCoefficients.count < numCoeffs {
            newCoefficients.append(lcm)
        }

        // Simplify the coefficients.
        if !newCoefficients.contains(0) {
            let simplifingFactor = newCoefficients.reduce(0) { Math.gcd($0, $1) }

             var finalCoefficients: [Int] = []

             for coeff in newCoefficients {
                 finalCoefficients.append(coeff / simplifingFactor)
             }

             return finalCoefficients
        } else {
            throw BalanceError.noAnswerError
        }
    }
}
