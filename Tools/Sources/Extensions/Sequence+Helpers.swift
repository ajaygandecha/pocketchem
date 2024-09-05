//
//  Sequence+Helpers.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Foundation

extension Sequence {

    /// Splits a string before a separator that is calculated dynamically.
    /// - Parameter isSeparator: Determines whether or not a character counts as a separator.
    /// - Returns: Split string.
    public func splitBefore(
        separator isSeparator: (Iterator.Element) throws -> Bool
    ) rethrows -> [AnySequence<Iterator.Element>] {
        var result: [AnySequence<Iterator.Element>] = []
        var subSequence: [Iterator.Element] = []

        var iterator = self.makeIterator()
        while let element = iterator.next() {
            if try isSeparator(element) {
                if !subSequence.isEmpty {
                    result.append(AnySequence(subSequence))
                }
                subSequence = [element]
            } else {
                subSequence.append(element)
            }
        }
        result.append(AnySequence(subSequence))
        return result
    }
}
