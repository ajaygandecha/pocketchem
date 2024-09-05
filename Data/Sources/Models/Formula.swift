//
//  Formula.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Foundation

/// Represents a formula for the reference tools.
public struct Formula {
    /// Title or name of the formula.
    public var title: String
    /// Formula with subscript / superscript formatting.
    public var formula: String
    /// Legend for the formula that describes variables.
    public var key: String?

    /// All thermochemistry formulas.
    public static var thermochemistryFormulas: [Formula] = [
        Formula(
         title: "Change in Standard Entropy",
         formula: "ΔS° = ΣS°products - ΣS°reactants",
         key: ""
        ),
        Formula(
         title: "Change in Standard Enthalpy",
         formula: "ΔH° = ΣH°_{f} products - ΣH°_{f} reactants",
         key: ""
        ),
        Formula(
         title: "Change in Standard Free Energy",
         formula: "ΔG° = ΣG°_{f} products - ΣG°_{f} reactants",
         key: ""
        ),
        Formula(
         title: "Standard Free Energy with Enthalpy",
         formula: "ΔG° = ΔH° - TΔS°",
         key: ""
        )
    ]

    /// All basic formulas.
    public static var formulas: [Formula] = [
        Formula(
         title: "Density",
         formula: "D = m / V",
         key: "D = Density\nm = Mass\nV = Volume"
        ),
        Formula(
         title: "Kelvin",
         formula: "K = °C + 273",
         key: "K = Kelvin\n°C = Celsius"
        ),
        Formula(
         title: "PVT Proportion",
         formula: "(P_{1}V_{1})/T_{1} = (P_{2}V_{2})/T_{2}",
         key: "P = Pressure\nV = Volume\nT = Temperature"
        ),
        Formula(
         title: "Pressure",
         formula: "P_{t} = P_{1} + P_{2} + P_{3}...",
         key: "P = Pressure"
        ),
        Formula(
         title: "Molarity Proportion",
         formula: "M_{1}V_{1} = M_{2}V_{2}",
         key: "M = Molarity\nV = Volume"
        ),
        Formula(
         title: "PVnRT Proportion",
         formula: "PV = nRT",
         key: "P = Pressure\nV = Volume\nn = Number of Moles\nR = Gas Constant\nT = Temperature"
        ),
        Formula(
         title: "Molarity",
         formula: "M = mol Solute / L Solution",
         key: "M = Molarity"
        ),
        Formula(
         title: "Quantity Heat Energy MCAT",
         formula: "q = mC_{p}ΔT",
         key: "q = Quantity Heat Energy\nC_{p} = Specific Heat\nΔT = Change in Temp"
        ),
        Formula(
         title: "Quantity Heat Energy HV",
         formula: "q = mH_{V}",
         key: "q = Quantity Heat Energy\nH_{V} = Heat of Vaporization"
        ),
        Formula(
         title: "Quantity Heat Energy HF",
         formula: "q = mH_{F}",
         key: "q = Quantity Heat Energy\nH_{F} = Heat of Fusion"
        ),
        Formula(
         title: "pH + pOH",
         formula: "pH + pOH = 14",
         key: "No Key"
        ),
        Formula(
         title: "pH Formula",
         formula: "pH = -log[H^{+}]",
         key: "H^{+} = Hydrogen Ions"
        ),
        Formula(
         title: "pOH Formula",
         formula: "pOH = -log[OH^{-}]",
         key: "OH^{-} = Hydroxide Ions"
        ),
        Formula(
         title: "Equil. Constant for Ioniz. Water",
         formula: "K_{W} = [H^{+}][OH^{-}] = 1 x 10^{-14}",
         key: "K_{W} = Equilibrium Constant\nH^{+} = Hydrogen Ions\nOH^{-} = Hydroxide Ions"
        )
    ]

    /// All formulas for synthesis reactions
    public static var synthesisReactions: [Formula] = [
        Formula(
         title: "Formation of Binary Compound",
         formula: "A + B -> AB"
        ),
        Formula(
         title: "Metal Oxide and Water",
         formula: "MO + H_{2}O -> Base"
        ),
        Formula(
         title: "Nonmetal Oxide and Water",
         formula: "(NM)O + H_{2}O -> Acid"
        )
    ]

    /// All formulas for decomposition reactions
    public static var decompositionReactions: [Formula] = [
        Formula(
         title: "Binary Compounds",
         formula: "AB -> A + B"
        ),
        Formula(
         title: "Metallic Carbonates",
         formula: "MCO_{3} -> MO + CO_{2}"
        ),
        Formula(
         title: "Metallic Hydrogen Carbonates",
         formula: "MHCO_{3} -> MCO_{3}(s) + H_{2}O(l) + CO_{2}(g)"
        ),
        Formula(
         title: "Metallic Hydroxides",
         formula: "MOH -> MO + H_{2}O"
        ),
        Formula(
         title: "Metallic Chlorates",
         formula: "ClO_{3} -> MCl + O_{2}"
        ),
        Formula(
         title: "Oxyacid Decomposition",
         formula: "Acid -> (NM)O + H_{2}O"
        )
    ]

    /// All formulas for single-replacement reactions
    public static var singleReplacementReactions: [Formula] = [
        Formula(
         title: "Metal-Metal Replacement",
         formula: "A + BC -> AC + B"
        ),
        Formula(
         title: "Active Metal Replaces H from Water",
         formula: "M + H_{2}O -> MOH + H_{2}"
        ),
        Formula(
         title: "Active Metal Replaces H from Acid",
         formula: "M + HX -> MX + H_{2}"
        ),
        Formula(
         title: "Halide-Halide Replacement",
         formula: "D + BC -> BD + C"
        )
    ]

    /// All formulas for double-replacement reactions
    public static var doubleReplacementReactions: [Formula] = [
        Formula(
         title: "Double Replacement",
         formula: "AB + CD -> AD + CB"
        )
    ]

    /// All formulas for combustion reactions
    public static var combustionReactions: [Formula] = [
        Formula(
         title: "Combustion Reaction",
         formula: "Hydrocarbon + Oxygen -> CO_{2} + H_{2}O"
        )
    ]

    /// All constant values, with formulas storing their values.
    public static var constantValues: [Formula] = [
        Formula(
         title: "Avogadro's Number",
         formula: "6.022 x 10^{23} particles / mole"
        ),
        Formula(
         title: "Speed of Light (c)",
         formula: "2.998 x 10^{8} m / s"
        ),
        Formula(
         title: "Planck's Constant",
         formula: "6.626 x 10^{-34} J s"
        ),
        Formula(
         title: "Faraday's Constant",
         formula: "96,485 coulombs / mol of e^{-}"
        ),
        Formula(
         title: "Gas Constant (R) - atm",
         formula: "0.0821 L atm / mol K"
        ),
        Formula(
         title: "Gas Constant (R) - mmHg",
         formula: "62.4 L mmHg / mol K"
        ),
        Formula(
         title: "Gas Constant (R) - kPa",
         formula: "8.314 L kPa / mol K"
        ),
        Formula(
         title: "Standard Pressure",
         formula: "1.00 atm = 101.3 kPa = 760 mmHg = 760 torr"
        ),
        Formula(
         title: "Standard Temperature",
         formula: "0°C = 273K"
        ),
        Formula(
         title: "Volume of 1 mol at STP",
         formula: "22.4 L"
        ),
        Formula(
         title: "Heat of Fusion of Water",
         formula: "334 J/g"
        ),
        Formula(
         title: "Heat of Vaporization of Water",
         formula: "2,260 J/g"
        ),
        Formula(
         title: "Specific Heat of Water (Ice)",
         formula: "2.05 J/g°C"
        ),
        Formula(
         title: "Specific Heat of Water (Liquid)",
         formula: "4.18 J/g°C"
        ),
        Formula(
         title: "Specific Heat of Water (Steam)",
         formula: "2.02 J/g°C"
        )
    ]
}
