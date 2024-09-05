//
//  Isotope.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 8/30/24.
//

import Foundation

public struct Isotope: Codable, Hashable {
    public var name: String
    public var mass: Double?
    public var naturalAbundance: Double?
    public var isNatural: Bool
    public var halfLife: String?
    public var modeOfDecay: String?

    public init(
        name: String,
        mass: Double? = nil,
        naturalAbundance: Double? = nil,
        isNatural: Bool,
        halfLife: String? = nil,
        modeOfDecay: String? = nil
    ) {
        self.name = name
        self.mass = mass
        self.naturalAbundance = naturalAbundance
        self.isNatural = isNatural
        self.halfLife = halfLife
        self.modeOfDecay = modeOfDecay
    }

    public func isotopeNumber(with element: Element) -> String {
        guard let indexForSymbol = self.name.firstIndex(of: element.symbol.first!) else { return "" }
        let numberText = self.name.split(separator: self.name[indexForSymbol])[0]
        return String(numberText)
    }
}
