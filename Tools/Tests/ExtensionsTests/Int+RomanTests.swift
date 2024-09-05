//
//  Int+RomanTests.swift
//  Tools
//
//  Created by Ajay Gandecha on 9/4/24.
//

import Testing
@testable import Tools

struct RomanTests {

    typealias RomanTestsItem = (number: Int, solution: String)

    @Test("Ensures converting numbers to roman numerals works correctly.",
        arguments: [
            (number: 1, solution: "I"),
            (number: 4, solution: "IV"),
            (number: 5, solution: "V"),
            (number: 6, solution: "VI"),
            (number: 9, solution: "IX"),
            (number: 56, solution: "LVI")
        ]
    )
    func testRoundedSuccess(item: RomanTestsItem) throws {
        let solution = item.number.romanNumeral
        #expect(solution == item.solution)
    }

    @Test("Ensures converting numbers to roman numerals >= 4000 does not work.")
    func testRoundedTooLarge() throws {
        let solution = 4000.romanNumeral
        #expect(solution == "Invalid input (greater than 3999)")
    }
}
