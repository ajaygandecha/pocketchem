//
//  ReactionsView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct ReactionsView: View {
    var body: some View {
        List {
            Section {
                FormulaGroupView(for: Formula.synthesisReactions)
            } header: {
                Label("Synthesis Reactions", systemImage: "apple.meditate")
            }
            Section {
                FormulaGroupView(for: Formula.decompositionReactions)
            } header: {
                Label("Decomposition Reactions", systemImage: "arrow.down.backward.and.arrow.up.forward")
            }
            Section {
                FormulaGroupView(for: Formula.singleReplacementReactions)
            } header: {
                Label("Single Replacement Reactions", systemImage: "1.brakesignal")
            }
            Section {
                FormulaGroupView(for: Formula.doubleReplacementReactions)
            } header: {
                Label("Double Replacement Reactions", systemImage: "2.brakesignal")
            }
            Section {
                FormulaGroupView(for: Formula.combustionReactions)
            } header: {
                Label("Combustion Reactions", systemImage: "sparkle")
            }
        }
        .navigationTitle("Chemical Reactions")
    }
}

#Preview {
    ReactionsView()
}
