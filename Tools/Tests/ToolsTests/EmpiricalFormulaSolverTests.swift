//
//  EmpiricalFormulaSolverTests.swift
//  Tools
//
//  Created by Ajay Gandecha on 9/4/24.
//

import Testing
import Data
@testable import Tools

struct EmpiricalFormulaSolverTests {

    typealias SolvedEmpiricalFormula = (input: [EmpiricalFormulaSolver.EmpiricalFormulaComponent], sol: String)

    @Test("Ensures that the empirical formula solver correctly solves the empirical formula.",
        arguments: [
            (
                input: [
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[5], // carbon
                        value: 52.14,
                        isPercent: false
                    ),
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[0], // hydrogen
                        value: 13.13,
                        isPercent: false
                    ),
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[7], // oxygen
                        value: 34.73,
                        isPercent: false
                    )
                ],
                sol: "C_{2}H_{6}O_{1}"
            ),
            (
                input: [
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[13], // silicon
                        value: 47.00,
                        isPercent: false
                    ),
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[7], // oxygen
                        value: 53.00,
                        isPercent: false
                    )
                ],
                sol: "Si_{1}O_{2}"
            ),
            (
                input: [
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[5], // carbon
                        value: 84.6,
                        isPercent: false
                    ),
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[0], // hydrogen
                        value: 15.4,
                        isPercent: false
                    )
                ],
                sol: "C_{6}H_{13}"
            ),
            (
                input: [
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[5], // carbon
                        value: 83.3,
                        isPercent: false
                    ),
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[0], // hydrogen
                        value: 16.7,
                        isPercent: false
                    )
                ],
                sol: "C_{5}H_{12}"
            ),
            (
                input: [
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[5], // carbon
                        value: 16.0,
                        isPercent: false
                    ),
                    EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                        element: DataStore.shared.elements[0], // hydrogen
                        value: 84.0,
                        isPercent: false
                    )
                ],
                sol: "C_{2}H_{125}"
            )
        ]
    )
    func testFindEmpiricalFormulaSuccess(input: SolvedEmpiricalFormula) throws {
        let solution = try EmpiricalFormulaSolver.findEmpiricalFormula(for: input.input)
        #expect(solution == input.sol)
    }

    @Test("Ensures that the solver fails if the input sums do not add up to 100.",
        arguments: [
            [
                EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                    element: DataStore.shared.elements[5], // carbon
                    value: 60.00,
                    isPercent: false
                ),
                EmpiricalFormulaSolver.EmpiricalFormulaComponent(
                    element: DataStore.shared.elements[0], // hydrogen
                    value: 20.00,
                    isPercent: false
                )
            ]
        ]
    )
    func testFindEmpiricalFormulaPercentSumError(input: [EmpiricalFormulaSolver.EmpiricalFormulaComponent]) throws {
        #expect(throws: EmpiricalFormulaSolver.SolverError.percentSumError) {
            try EmpiricalFormulaSolver.findEmpiricalFormula(for: input)
        }
    }
}
