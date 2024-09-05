//
//  Element.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 8/30/24.
//

import SwiftUI

public struct Element: Identifiable, Codable, Hashable {

    public var id: Int { self.atomicNumber }
    public var atomicNumber: Int
    public var symbol: String
    public var name: String
    public var casNumber: String
    public var atomicMass: Double
    public var electronConfiguration: String
    public var electronegativity: Double?
    public var atomicRadius: Double?
    public var ionizationEnergy: Double?
    public var electronAffinity: Double?
    public var oxidationStates: String?
    public var stpMatterState: MatterState
    public var meltingPoint: Double?
    public var boilingPoint: Double?
    public var density: Double?
    public var elementClass: ElementClassification
    public var yearDiscovered: Int
    public var isotopes: [Isotope]
    public var uses: String
    public var history: String
    public var elementOfTheDayPromo: String

    public var color: Color {
        return self.elementClass.color
    }

    public static let electronShellRanges = [
        1: 1...2,
        2: 3...10,
        3: 11...18,
        4: 19...36,
        5: 37...54,
        6: 55...86,
        7: 87...118
    ]

    public var electronShells: Int {
        for (levels, electronShellRange) in Element.electronShellRanges
            where electronShellRange.contains(self.atomicNumber) {
            return levels
        }
        return 7
    }

    public var periodicTableRow: Int {
        if self.elementClass == .lanthanide {
            return 8
        }
        if self.elementClass == .actinide {
            return 9
        }
        return self.electronShells
    }

    public var periodicTableGroup: Int {
        let rowOffset = self.atomicNumber - Element.electronShellRanges[self.electronShells]!.lowerBound + 1
        if self.periodicTableRow == 1 && rowOffset > 1 {
            return rowOffset + 16
        }
        if (self.periodicTableRow == 2 || self.periodicTableRow == 3) && rowOffset > 2 {
            return rowOffset + 10
        }
        if self.periodicTableRow == 6 || self.periodicTableRow == 7 {
            if rowOffset > 17 {
                return rowOffset - 14
            }
        }
        return rowOffset
    }

    public var smallPeriodicTablePosition: Int {
        (self.periodicTableRow - 1) * 18 + (periodicTableGroup - 1)
    }

    public static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.atomicNumber == rhs.atomicNumber
    }

    /// Determines whether an element should be shown based on a provided seach query.
    /// - Parameter query: Search query from a search bar.
    /// - Returns: Whether or not to show the element.
    public func matchesQuery(query: String) -> Bool {
        return query.isEmpty ||
        String(self.atomicNumber) == query ||
        self.name.lowercased().starts(with: query.lowercased()) ||
        self.symbol.lowercased().starts(with: query.lowercased()) ||
        self.elementClass.rawValue.lowercased().starts(with: query.lowercased())
    }
}

// TODO: Refactor hard-coded extension values and move data to the JSON file.

/// Handles element radioactivity.
public extension Element {

    private static var radioactiveElementsAtomicNumbers: Set<Int> = Set([
        43, // Technetium
        61, // Promethium
        84, // Polonium
        85, // Astatine
        86, // Radon
        87, // Francium
        88, // Radium
        89, // Actinium
        90, // Thorium
        91, // Protactinium
        92, // Uranium
        93, // Neptunium
        94, // Plutonium
        95, // Americium
        96, // Curium
        97, // Berkelium
        98, // Californium
        99, // Einsteinium
        100, // Fermium
        101, // Mendelevium
        102, // Nobelium
        103, // Lawrencium
        104, // Rutherfordium
        105, // Dubnium
        106, // Seaborgium
        107, // Bohrium
        108, // Hassium
        109, // Meitnerium
        110, // Darmstadtium
        111, // Roentgenium
        112, // Copernicium
        113, // Nihonium
        114, // Flerovium
        115, // Moscovium
        116, // Livermorium
        117, // Tennessine
        118  // Oganesson
    ])

    /// Whether or not this element is radioactive.
    var isRadioactive: Bool {
        return Element.radioactiveElementsAtomicNumbers.contains(self.atomicNumber)
    }
}

/// Handles element flame colors.
public extension Element {

    /// Determines the primary and secondary colors for flame colors.
    var flameColor: (primary: UIColor?, secondary: UIColor?) {

        switch self.name {
        case "Lithium":
            return (primary: UIColor(red: 212.0/255.0, green: 58.0/255.0, blue: 78.0/255.0, alpha: 1),
                    secondary: UIColor(red: 233.0/255.0, green: 159.0/255.0, blue: 95.0/255.0, alpha: 1))
        case "Sodium":
            return (primary: UIColor(red: 239.0/255.0, green: 179.0/255.0, blue: 69.0/255.0, alpha: 1),
                    secondary: UIColor(red: 223.0/255.0, green: 123.0/255.0, blue: 63.0/255.0, alpha: 1))
        case "Potassium":
            return (primary: UIColor(red: 170.0/255.0, green: 124.0/255.0, blue: 174.0/255.0, alpha: 1),
                    secondary: UIColor(red: 176.0/255.0, green: 167.0/255.0, blue: 206.0/255.0, alpha: 1))
        case "Rubidium":
            return (primary: UIColor(red: 190.0/255.0, green: 117.0/255.0, blue: 135.0/255.0, alpha: 1),
                    secondary: UIColor(red: 197.0/255.0, green: 171.0/255.0, blue: 192.0/255.0, alpha: 1))
        case "Cesium":
            return (primary: UIColor(red: 149.0/255.0, green: 145.0/255.0, blue: 186.0/255.0, alpha: 1),
                    secondary: UIColor(red: 117.0/255.0, green: 146.0/255.0, blue: 187.0/255.0, alpha: 1))
        case "Calcium":
            return (primary: UIColor(red: 206.0/255.0, green: 93.0/255.0, blue: 47.0/255.0, alpha: 1),
                    secondary: UIColor(red: 226.0/255.0, green: 154.0/255.0, blue: 62.0/255.0, alpha: 1))
        case "Strontium":
            return (primary: UIColor(red: 215.0/255.0, green: 78.0/255.0, blue: 55.0/255.0, alpha: 1),
                    secondary: UIColor(red: 229.0/255.0, green: 169.0/255.0, blue: 65.0/255.0, alpha: 1))
        case "Barium":
            return (primary: UIColor(red: 174.0/255.0, green: 197.0/255.0, blue: 66.0/255.0, alpha: 1),
                    secondary: UIColor(red: 193.0/255.0, green: 215.0/255.0, blue: 170.0/255.0, alpha: 1))
        case "Radium":
            return (primary: UIColor(red: 199.0/255.0, green: 50.0/255.0, blue: 79.0/255.0, alpha: 1),
                    secondary: UIColor(red: 192.0/255.0, green: 118.0/255.0, blue: 167.0/255.0, alpha: 1))
        case "Copper":
            return (primary: UIColor(red: 115.0/255.0, green: 181.0/255.0, blue: 139.0/255.0, alpha: 1),
                    secondary: UIColor(red: 159.0/255.0, green: 200.0/255.0, blue: 162.0/255.0, alpha: 1))
        case "Iron":
            return (primary: UIColor(red: 243.0/255.0, green: 192.0/255.0, blue: 68.0/255.0, alpha: 1),
                    secondary: UIColor(red: 246.0/255.0, green: 241.0/255.0, blue: 182.0/255.0, alpha: 1))
        case "Boron":
            return (primary: UIColor(red: 93.0/255.0, green: 162.0/255.0, blue: 70.0/255.0, alpha: 1),
                    secondary: UIColor(red: 147.0/255.0, green: 196.0/255.0, blue: 162.0/255.0, alpha: 1))
        case "Indium":
            return (primary: UIColor(red: 92.0/255.0, green: 134.0/255.0, blue: 192.0/255.0, alpha: 1),
                    secondary: UIColor(red: 128.0/255.0, green: 198.0/255.0, blue: 234.0/255.0, alpha: 1))
        case "Lead":
            return (primary: UIColor(red: 187.0/255.0, green: 221.0/255.0, blue: 229.0/255.0, alpha: 1),
                    secondary: UIColor(red: 142.0/255.0, green: 201.0/255.0, blue: 215.0/255.0, alpha: 1))
        case "Arsenic":
            return (primary: UIColor(red: 153.0/255.0, green: 188.0/255.0, blue: 225.0/255.0, alpha: 1),
                    secondary: UIColor(red: 116.0/255.0, green: 187.0/255.0, blue: 226.0/255.0, alpha: 1))
        case "Antimony":
            return (primary: UIColor(red: 188.0/255.0, green: 215.0/255.0, blue: 182.0/255.0, alpha: 1),
                    secondary: UIColor(red: 146.0/255.0, green: 197.0/255.0, blue: 174.0/255.0, alpha: 1))
        case "Selenium":
            return (primary: UIColor(red: 105.0/255.0, green: 149.0/255.0, blue: 203.0/255.0, alpha: 1),
                    secondary: UIColor(red: 58.0/255.0, green: 130.0/255.0, blue: 193.0/255.0, alpha: 1))
        case "Zinc":
            return (primary: UIColor(red: 185.0/255.0, green: 217.0/255.0, blue: 202.0/255.0, alpha: 1),
                    secondary: UIColor(red: 130.0/255.0, green: 193.0/255.0, blue: 188.0/255.0, alpha: 1))
        default:
            return (primary: nil, secondary: nil)
        }
    }
}
