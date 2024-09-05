//
//  SolubilityRulesView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct SolubilityRulesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("All Nitrates, Acetates, Ammonium, and Group 1 (IA) salts")
                    Text("All Chlorides, Bromides, and Iodides, EXCEPT Silver, Lead, and Mercury (I)")
                    Text("All Fluorides except Group 2 (IIA), Lead (II), and Iron (III)")
                    Text("All Sulfates except Calcium, Strontium, Barium, Mercury, Lead (II), and Silver")
                } header: {
                    Label("Soluable", systemImage: "drop.degreesign")
                }
                Section {
                    Text("All Carbonates and Phosphates except Group 1 (IA) and Ammonium")
                    Text("All Hydroxides except Group 1 (IA), Strontium, Barium, and Ammonium")
                    Text("All Sulfides except Group 1 (IA), 2 (IIA), and Ammonium")
                    Text("All Oxides except Group 1 (IA)")
                } header: {
                    Label("Insoluable", systemImage: "drop.degreesign.slash")
                }
            }
            .navigationTitle("Solubility Rules")
        }
    }
}

#Preview {
    SolubilityRulesView()
}
