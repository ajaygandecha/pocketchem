//
//  ChemicalEquationBalancerTests.swift
//  Tools
//
//  Created by Ajay Gandecha on 9/4/24.
//

import Testing
@testable import Tools

struct ChemicalEquationBalancerTests {

    typealias ChemicalEquation = (reactants: String, products: String)
    typealias SolvedChemicalEquation = (reactants: String, products: String, sol: String)

    @Test("Ensures that the chemical equation balancer correctly balances valid equations.",
        arguments: [
            (reactants: "CO2+H2O", products: "C6H12O6+O2", sol: "6CO2 + 6H2O = 1C6H12O6 + 6O2"),
            (reactants: "CO2 + H2O", products: "C6H12O6 + O2", sol: "6CO2 + 6H2O = 1C6H12O6 + 6O2"),
            (reactants: "CH4+O2", products: "CO2+H2O", sol: "1CH4 + 2O2 = 1CO2 + 2H2O"),
            (reactants: "CO2+NH3", products: "OC(NH2)2+H2O", sol: "1CO2 + 2NH3 = 1OC(NH2)2 + 1H2O"),
            (reactants: "P4+O2", products: "P2O5", sol: "1P4 + 5O2 = 2P2O5"),
            (reactants: "Fe2(SO4)3 + KOH", products: "K2SO4 + Fe(OH)3", sol: "1Fe2(SO4)3 + 6KOH = 3K2SO4 + 2Fe(OH)3"),
            (reactants: "K +Br2", products: "KBr", sol: "2K + 1Br2 = 2KBr")
        ]
    )
    func testBalanceChemicalEquationSuccess(equation: SolvedChemicalEquation) throws {
        let solution = try ChemicalEquationBalancer.balanceChemicalEquation(
            reactants: equation.reactants,
            products: equation.products
        )
        #expect(solution == equation.sol)
    }

    @Test("Ensures that the chemical equation fails if the provided equation is missing reactants or products.",
        arguments: [
            (reactants: "CO2+H2O", products: ""),
            (reactants: "", products: "C6H12O6+O2")
        ]
    )
    func testBalanceChemicalEquationMissingReactantsOrProducts(equation: ChemicalEquation) throws {
        #expect(throws: ChemicalEquationBalancer.BalanceError.missingReactantsOrProducts) {
            try ChemicalEquationBalancer.balanceChemicalEquation(
                reactants: equation.reactants,
                products: equation.products
            )
        }
    }

    @Test("Ensures that the chemical equation fails if the provided equation includes incorrect delimeters.",
        arguments: [
            (reactants: "Fe2[SO4]3 + KOH", products: "K2SO4 + Fe[OH]3"),
            (reactants: "Fe2(SO4)3 + KOH", products: "K2SO4 + Fe[OH]3"),
            (reactants: "Fe2{SO4}3 + KOH", products: "K2SO4 + Fe{OH}3"),
            (reactants: "Fe2<SO4>3 + KOH", products: "K2SO4 + Fe<OH>3")
        ]
    )
    func testBalanceChemicalEquationNonNormalDelimeter(equation: ChemicalEquation) throws {
        #expect(throws: ChemicalEquationBalancer.BalanceError.nonNormalDelimiterError) {
            try ChemicalEquationBalancer.balanceChemicalEquation(
                reactants: equation.reactants,
                products: equation.products
            )
        }
    }

    @Test("Ensures that the chemical equation fails if the provided equation is invalid.",
        arguments: [
            (reactants: "CO2+H2O", products: "C6H12O6-O2"),
            (reactants: "CO2+H2O)", products: "C6H12O6+O2"),
            (reactants: "sdfhofsuhousdfh", products: "testing123"),
            (reactants: "O_2", products: "testing123")
        ]
    )
    func testBalanceChemicalEquationInvalidInput(equation: ChemicalEquation) throws {
        #expect(throws: ChemicalEquationBalancer.BalanceError.self) {
            try ChemicalEquationBalancer.balanceChemicalEquation(
                reactants: equation.reactants,
                products: equation.products
            )
        }
    }

    @Test("Ensures that the chemical equation fails if no solution exists.",
        arguments: [
            (reactants: "(NH4)2 + SO4", products: "NH4OH + SO2")
        ]
    )
    func testBalanceChemicalEquationNoSolution(equation: ChemicalEquation) throws {
        #expect(throws: ChemicalEquationBalancer.BalanceError.noAnswerError) {
            try ChemicalEquationBalancer.balanceChemicalEquation(
                reactants: equation.reactants,
                products: equation.products
            )
        }
    }
}
