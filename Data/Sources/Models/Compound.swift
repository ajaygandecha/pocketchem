//
//  Compound.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 8/30/24.
//

import Foundation

/// Represents a chemical compound.
public struct Compound {
    /// Name of the compound.
    public var name: String
    /// Chemical formula of the compound.
    public var formula: String
    /// Name of the salt, if any.
    public var saltName: String?
    /// Type of the compound.
    public var type: CompoundType
}

/// Type of compound.
public enum CompoundType {
    /// Base compound
    case base
    /// Oxide compound
    case oxide
    /// Common compound
    case common
    /// Acid compound
    case acid
}
