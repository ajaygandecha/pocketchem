//
//  AcidsBasesView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct AcidsBasesView: View {
    var body: some View {
        List {
            Section {
                SubSuperScriptText("HCl - Hydrochloric Acid")
                SubSuperScriptText("HBr - Hydrobromic Acid")
                SubSuperScriptText("HI - Hydroiodic Acid")
                SubSuperScriptText("H_{2}SO_{4} - Hydrosulfuric Acid")
                SubSuperScriptText("HNO_{3} - Nitric Acid")
                SubSuperScriptText("HClO_{4} - Perchloric Acid")
            } header: {
                Label("Strong Acids", systemImage: "flask")
            }

            Section {
                SubSuperScriptText("LiOH - Lithium Hydroxide")
                SubSuperScriptText("NaOH - Sodium Hydroxide")
                SubSuperScriptText("KOH - Potassium Hydroxide")
                SubSuperScriptText("RbOH - Rubidium Hydroxide")
                SubSuperScriptText("CsOH - Cesium Hydroxide")
                SubSuperScriptText("Ca(OH)_{2} - Calcium Hydroxide")
                SubSuperScriptText("Sr(OH)_{2} - Strontium Hydroxide")
                SubSuperScriptText("Ba(OH)_{2} - Barium Hydroxide")

            } header: {
                Label("Strong Bases", systemImage: "aqi.medium")
            }
        }
        .navigationTitle("Strong Acids & Bases")
    }
}

#Preview {
    AcidsBasesView()
}
