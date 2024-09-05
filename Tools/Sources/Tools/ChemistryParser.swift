//
//  ChemistryParser.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data

/// Service that contains business logic to parse strings of chemical equations.
public struct ChemistryParser {

    /// Extracts the elements and numbers from compounds, provided in a string format.
    /// - Parameter compound: Compound molecule in string format.
    /// - Returns: Map of elements to their count.
    static func elementsAndNumbersFromCompound(from compound: String) -> [String: Int] {
        var item = compound

        var elementData: [String: Int] = [:]

        if item.contains("(") {

            let elementDataForFront = elementsAndNumbersFromItem(item: item.components(separatedBy: "(")[0])

            for (element, value) in elementDataForFront {
                elementData[element] = value
            }
        }

        while item.contains("(") {

            let innerParen = item.components(separatedBy: "(")[1].components(separatedBy: ")")[0]
            let numberParen = Int(
                item.components(separatedBy: ")")[1].splitBefore(separator: {$0.isLetter}).map {String($0)}[0]
            )

            let elementDataForInner = elementsAndNumbersFromItem(item: innerParen)

            for (element, value) in elementDataForInner {

                if elementData.keys.contains(element) {
                    elementData[element] = elementData[element]! + (value * (numberParen ?? 1))
                } else {
                    elementData[element] = (value * (numberParen ?? 1))
                }
            }

            let locationOfParen = item.firstIndex(of: ")")!
            item = String(String(item[locationOfParen...]).dropFirst())
        }

        let elementDataForRest = elementsAndNumbersFromItem(item: item)

        for (element, value) in elementDataForRest {

            if elementData.keys.contains(element) {
                elementData[element] = elementData[element]! + value
            } else {
                elementData[element] = value
            }
        }

        return elementData
    }

    /// Extracts the elements and numbers from individual items, provided in a string format.
    /// - Parameter compound: Compound molecule in string format.
    /// - Returns: Map of elements to their count.
    static func elementsAndNumbersFromItem(item: String) -> [String: Int] {

        var returnDict: [String: Int] = [:]

        let separatedElements: [String] = item.splitBefore(separator: {$0.isUppercase && $0.isLetter}).map {String($0)}

        for element in separatedElements where !["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"].contains(element) {

            let splitElement: [String] = element.splitBefore(separator: {$0.isNumber}).map {String($0)}

            if splitElement.count == 1 {
                if returnDict.keys.contains(element) {
                    returnDict[element]! += 1
                } else {
                    returnDict[element] = 1
                }
            } else {

                var numText = ""

                for item in splitElement[1...] {
                    numText += item
                }

                returnDict[splitElement[0]] = Int(numText)
            }
        }

        return returnDict
    }
}
