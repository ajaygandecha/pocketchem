//
//  MolecularFormulaSolver.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data

/// Service that contains business logic to solve molecular formulas.
public struct MolecularFormulaSolver {

    /// Error thrown by the molecular formula solver.
    public enum SolverError: Error {
        case symbolException
    }

    /// Finds the molecular constant to determine the molecular formula.
    /// - Parameters:
    ///   - empiricalFormula: Solved empirical formula.
    ///   - molecularMass: Molecular mass for the calculation.
    /// - Returns: Molecular constant to multiply the empirical formula constants by.
    public static func findMolecularFormula(empiricalFormula: String, molecularMass: Double) throws -> Double {

        // Find the map of elements to numbers provided in the empirical formula.
        let elementCount = ChemistryParser.elementsAndNumbersFromCompound(from: empiricalFormula)

        // Determine the empirical mass.
        var empiricalMass = 0.0

        for (symbol, count) in elementCount {
            let element = DataStore.shared.elements.first(where: { $0.symbol == symbol })
            guard let elementUnwrapped = element else { throw SolverError.symbolException }
            empiricalMass += (elementUnwrapped.atomicMass * Double(count))
        }

        // Find the ratio of the molecular mass to the calculated empirical mass and round it down.
        let ratio = (molecularMass / empiricalMass).rounded(.toNearestOrAwayFromZero)

        // Return the final ratio.
        return ratio
    }

}
