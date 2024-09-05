//
//  ConstantsView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct ConstantsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    FormulaGroupView(for: Formula.constantValues)
                } header: {
                    Label("All Constant Values", systemImage: "numbers.rectangle")
                }
            }
            .navigationTitle("Constant Values")
        }
    }
}

#Preview {
    ConstantsView()
}
