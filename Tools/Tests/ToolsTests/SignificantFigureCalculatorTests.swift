//
//  SignificantFigureCalculatorTests.swift
//  Tools
//
//  Created by Ajay Gandecha on 9/4/24.
//

import Testing
@testable import Tools

struct SignificantFigureCalculatorTests {

    typealias CalculatorSolution = (input: String, count: Int, indexes: [Int])

    @Test("Ensures that the calculator correctly counts the number of significant figures.",
        arguments: [
            (input: "301", count: 3, indexes: [0, 1, 2]),
            (input: "100.007", count: 6, indexes: [0, 1, 2, 4, 5, 6]),
            (input: "100.000", count: 6, indexes: [0, 1, 2, 4, 5, 6]),
            (input: "400.", count: 3, indexes: [0, 1, 2]),
            (input: "400", count: 1, indexes: [0]),
            (input: "400,000", count: 1, indexes: [0])
        ]
    )
    func testCalculateSignificantFiguresSuccess(input: CalculatorSolution) throws {
        let solution = try SignificantFigureCalculator.calculateSignificantFigures(for: input.input)
        #expect(solution.numberOfSigFigs == input.count)
        #expect(solution.locationsOfSigFigs == Set(input.indexes))
    }

    @Test("Ensures that the calculator fails if the included number has too many periods.",
        arguments: [
            (input: "301.2.2", count: 0, indexes: []),
            (input: "1..2", count: 0, indexes: [])
        ]
    )
    func testCalculateSignificantFiguresTooManyPeriods(input: CalculatorSolution) throws {
        #expect(throws: SignificantFigureCalculator.CalculationError.tooManyPeriods) {
            try SignificantFigureCalculator.calculateSignificantFigures(for: input.input)
        }
    }

    @Test("Ensures that the calculator fails if the included number has invalid characters.",
        arguments: [
            (input: "123.abc", count: 0, indexes: []),
            (input: "12/2", count: 0, indexes: [])
        ]
    )
    func testCalculateSignificantFiguresInvalidCharacters(input: CalculatorSolution) throws {
        #expect(throws: SignificantFigureCalculator.CalculationError.containsNotAcceptedCharacters) {
            try SignificantFigureCalculator.calculateSignificantFigures(for: input.input)
        }
    }
}
