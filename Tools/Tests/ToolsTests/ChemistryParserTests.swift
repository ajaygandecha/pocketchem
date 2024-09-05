//
//  ChemistryParserTests.swift
//  Tools
//
//  Created by Ajay Gandecha on 9/4/24.
//

import Testing
@testable import Tools

struct ChemistryParserTests {

    typealias ChemistryParserSolution = (input: String, solution: [String: Int])

    @Test("Ensures that the chemical equation balancer correctly balances valid equations.",
        arguments: [
            (input: "C6H12O6", solution: ["C": 6, "H": 12, "O": 6]),
            (input: "CHOOH", solution: ["C": 1, "H": 2, "O": 2]),
            (input: "Fe2(SO4)3", solution: ["Fe": 2, "S": 3, "O": 12]),
            (input: "Fe2(SO4)3O3", solution: ["Fe": 2, "S": 3, "O": 15]),
            (input: "H2(H2H4)2H14", solution: ["H": 24])
        ]
    )
    func testElementsAndNumbersFromCompoundSuccess(input: ChemistryParserSolution) {
        let solution = ChemistryParser.elementsAndNumbersFromCompound(from: input.input)
        #expect(solution == input.solution)
    }
}
