//
//  ElementClassification.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 8/30/24.
//

import SwiftUI

public enum ElementClassification: String, CaseIterable, Codable {

    case hydrogen = "Hydrogen"
    case nonmetal = "Nonmetal"
    case noblegas = "Noble Gas"
    case alkaliMetal = "Alkali Metal"
    case alkalineEarthMetal = "Alkaline Earth Metal"
    case metalloid = "Metalloid"
    case halogen = "Halogen"
    case postTransitionMetal = "Post-Transition Metal"
    case lanthanide = "Lanthanide"
    case actinide = "Actinide"
    case transitionMetal = "Transition Metal"

    public var color: Color {
        switch self {
        case .hydrogen:
            return Color("pcOrangeColor", bundle: Bundle.main)
        case .alkaliMetal:
            return Color("pcMagentaColor", bundle: Bundle.main)
        case .alkalineEarthMetal:
            return Color("pcLightPinkColor", bundle: Bundle.main)
        case .transitionMetal:
            return Color("pcTurquoiseColor", bundle: Bundle.main)
        case .lanthanide:
            return Color("pcLimeColor", bundle: Bundle.main)
        case .actinide:
            return Color("pcGrayBlueColor", bundle: Bundle.main)
        case .metalloid:
            return Color("pcYellowColor", bundle: Bundle.main)
        case .postTransitionMetal:
            return Color("pcSkyColor", bundle: Bundle.main)
        case .nonmetal:
            return Color("pcNavyColor", bundle: Bundle.main)
        case .halogen:
            return Color("pcPurpleColor", bundle: Bundle.main)
        case .noblegas:
            return Color("pcLavenderColor", bundle: Bundle.main)
        }
    }
}
