//
//  Math+Helpers.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Foundation

struct Math {

    /// Coloquial representation of a matrix of decimal numbers.
    public typealias Matrix = [[Double]]

    /// Coloquial representation of a fraction of two integers, keeping
    /// their numerators and denominators in-tact as properties.
    public typealias Rational = (numerator: Int, denominator: Int)

    /// Computes the greatest common denominator between two input numbers.
    /// - Parameters:
    ///   - numOne: First input number.
    ///   - numTwo: Second input number.
    /// - Returns: Greatest common denominator between both `a` and `b`.
    public static func gcd(_ numOne: Int, _ numTwo: Int) -> Int {
        let remainder = abs(numOne) % abs(numTwo)
        if remainder != 0 {
            return gcd(abs(numTwo), remainder)
        } else {
            return abs(numTwo)
        }
    }

    //   swiftlint:disable identifier_name
    /// Computes the reduced-row echelon form of a given matrix by performing
    /// Gauss-Jordan elimination on the provided matrix.
    /// - Parameter M: Input matrix.
    /// - Returns: Matrix in reduced-row echelon form.
    ///
    /// - Note: This function has been adapted from pseudocode, and therefore,
    ///   the variable names are not readable. This code has to be refactored.
    public static func rref(_ matrix: Matrix) -> Matrix {

        var m = matrix

        var lead = 0

        let rows = m.count
        let cols = m[0].count

        for r in 0..<rows {
            if cols <= lead { break }
            var i = r
            while m[i][lead] == 0 {
                i += 1
                if i == rows {
                    i = r
                    lead += 1
                    if cols == lead {
                        lead -= 1
                        break
                    }
                }
            }
            // Swap rows r and i
            for j in 0..<cols {
                let temp = m[r][j]
                m[r][j] = m[i][j]
                m[i][j] = temp
            }
            // Normalize the row so that the leading entry is 1
            let div = m[r][lead]
            if div != 0 {
                for j in 0..<cols {
                    m[r][j] /= div
                }
            }
            // Eliminate the leading entry from all other rows
            for j in 0..<rows where j != r {
                let sub = m[j][lead]
                for k in 0..<cols {
                    m[j][k] -= (sub * m[r][k])
                }
            }
            lead += 1
        }

        return m
    }
    //   swiftlint:enable identifier_name

    //   swiftlint:disable identifier_name
    /// Approximates the numerator and denominator of a given decimal number as a ratio.
    /// - Parameters:
    ///   - input: Given decimal number to approximate.
    ///   - eps: Degree of precision for approximation.
    /// - Returns: Rational construction with a numerator and denominator.
    ///
    /// - Note: This function has been adapted from pseudocode, and therefore,
    ///   the variable names are not readable. This code has to be refactored.
    public static func rationalApproximation(of input: Double, withPrecision epsilon: Double = 1.0E-6) -> Rational {
        var x = input
        var a = x.rounded(.down)
        var (h1, k1, h, k) = (1, 0, Int(a), 1)

        while x - a > epsilon * Double(k) * Double(k) {
            x = 1.0/(x - a)
            a = x.rounded(.down)
            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
        }
        return (h, k)
    }
    //   swiftlint:enable identifier_name
}
