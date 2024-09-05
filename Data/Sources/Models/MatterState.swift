//
//  MatterState.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 8/30/24.
//

import Foundation

public enum MatterState: String, Codable {

    case solid = "Solid"
    case liquid = "Liquid"
    case gas = "Gas"
    case solidExpected = "Solid (expected)"
    case liquidExpected = "Liquid (expected)"
    case gasExpected = "Gas (expected)"
}
