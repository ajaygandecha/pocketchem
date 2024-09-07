//
//  ReferenceView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct ReferenceView: View {
    var body: some View {
        List {
            Section {
                NavigationLink {
                    FormulasView()
                } label: {
                    Label {
                        Text("All Formulas")
                    } icon: {
                        Image(systemName: "equal.square")
                            .foregroundStyle(.pcMagenta)
                    }
                    .frame(height: 36)
                }
                NavigationLink {
                    AcidsBasesView()
                } label: {
                    Label {
                        Text("Strong Acids & Bases")
                    } icon: {
                        Image(systemName: "flask")
                            .foregroundStyle(.pcOrange)
                    }
                    .frame(height: 36)
                }
                NavigationLink {
                    SolubilityRulesView()
                } label: {
                    Label {
                        Text("Solubility Rules")
                    } icon: {
                        Image(systemName: "drop.degreesign")
                            .foregroundStyle(.pcYellow)
                    }
                    .frame(height: 36)
                }
                NavigationLink {
                    ReactionsView()
                } label: {
                    Label {
                        Text("Reactions")
                    } icon: {
                        Image(systemName: "aqi.medium")
                            .foregroundStyle(.pcTurquoise)
                    }
                    .frame(height: 36)
                }
                NavigationLink {
                    ConstantsView()
                } label: {
                    Label {
                        Text("Constant Values")
                    } icon: {
                        Image(systemName: "number")
                            .foregroundStyle(.pcSky)
                    }
                    .frame(height: 36)
                }
                NavigationLink {
                    MetricPrefixesView()
                } label: {
                    Label {
                        Text("Metric Prefixes")
                    } icon: {
                        Image(systemName: "ruler")
                            .foregroundStyle(.pcPurple)
                    }
                    .frame(height: 36)
                }
            } header: {
                Label("All Reference Tools", systemImage: "book")
            }
        }
        .navigationTitle("Reference")
        .environment(\.defaultMinListRowHeight, 36)
    }
}

#Preview {
    ReferenceView()
}
