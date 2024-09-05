//
//  Double+RoundingTests.swift
//  Tools
//
//  Created by Ajay Gandecha on 9/4/24.
//

import Testing
@testable import Tools

struct RoundingTests {

    typealias RoundedTestItem = (number: Double, places: Int, solution: Double)
    typealias RoundedStringTestItem = (number: Double, places: Int, solution: String)

    @Test("Ensures rounding to decimal places works correctly.",
        arguments: [
            (number: 123.4567, places: 3, solution: 123.457),
            (number: 3.14159265, places: 3, solution: 3.142),
            (number: 3.14159265, places: 0, solution: 3.0)
        ]
    )
    func testRounded(item: RoundedTestItem) throws {
        let solution = item.number.rounded(to: item.places)
        #expect(solution == item.solution)
    }

    @Test("Ensures string rounding works correctly.",
        arguments: [
            (number: 123.4567, places: 3, solution: "123.457"),
            (number: 3.14159265, places: 3, solution: "3.142"),
            (number: 3.14159265, places: 1, solution: "3.1")
        ]
    )
    func testRoundedString(item: RoundedStringTestItem) throws {
        let solution = item.number.roundedString(to: item.places)
        #expect(solution == item.solution)
    }
}
