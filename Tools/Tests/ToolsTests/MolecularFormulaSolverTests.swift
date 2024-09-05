//
//  MolecularFormulaSolverTests.swift
//  Tools
//
//  Created by Ajay Gandecha on 9/4/24.
//

import Testing
@testable import Tools

struct MolecularFormulaSolverTests {

    typealias SolvedMolecularFormula = (empirical: String, mass: Double, sol: Double)

    @Test("Ensures that the molecular formula solver correctly finds the molecular constant",
        arguments: [
            (empirical: "C2H6O", mass: 200.0, sol: 4.0),
            (empirical: "P2O5", mass: 283.89, sol: 2.0)
        ]
    )
    func testFindMolecularFormulaSuccess(input: SolvedMolecularFormula) throws {
        let solution = try MolecularFormulaSolver.findMolecularFormula(
            empiricalFormula: input.empirical,
            molecularMass: input.mass
        )
        #expect(solution == input.sol)
    }

    @Test("Ensures that the molecular formula solver fails if provided an invalid formula.",
        arguments: [
            (empirical: "random123", mass: 100.0, sol: 2.0)
        ]
    )
    func testFindEmpiricalFormulaPercentSymbolError(input: SolvedMolecularFormula) throws {
        #expect(throws: MolecularFormulaSolver.SolverError.symbolException) {
            try MolecularFormulaSolver.findMolecularFormula(
                empiricalFormula: input.empirical,
                molecularMass: input.mass
            )
        }
    }

}
