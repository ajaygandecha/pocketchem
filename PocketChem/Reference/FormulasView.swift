//
//  FormulasView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct FormulasView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    FormulaGroupView(for: Formula.formulas)
                } header: {
                    Label("Basic Formulas", systemImage: "equal.square")
                }

                Section {
                    FormulaGroupView(for: Formula.thermochemistryFormulas)
                } header: {
                    Label("Thermochemistry Formulas", systemImage: "thermometer.high")
                }
            }
            .navigationTitle("Formulas")
        }
    }
}

#Preview {
    FormulasView()
}
