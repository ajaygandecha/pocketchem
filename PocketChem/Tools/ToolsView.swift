//
//  ToolsView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct ToolsView: View {
    var body: some View {
        List {
            Section {
                NavigationLink {
                    EquationBalancerView()
                } label: {
                    Label {
                        Text("Chemical Equation Balancer")
                    } icon: {
                        Image(systemName: "level")
                            .foregroundStyle(.pcLime)
                    }
                    .frame(height: 36)
                }
                NavigationLink {
                    SignificantFiguresView()
                } label: {
                    Label {
                        Text("Find Significant Figures")
                    } icon: {
                        Image(systemName: "number.circle")
                            .foregroundStyle(.pcLavender)
                    }
                    .frame(height: 36)
                }
                NavigationLink {
                    EmpiricalSolverView()
                } label: {
                    Label {
                        Text("Empirical Formula Solver")
                    } icon: {
                        Image(systemName: "sparkle.magnifyingglass")
                            .foregroundStyle(.pcLightPink)
                    }
                    .frame(height: 36)
                }
                NavigationLink {
                    MolecularSolverView()
                } label: {
                    Label {
                        Text("Molecular Formula Solver")
                    } icon: {
                        Image(systemName: "1.magnifyingglass")
                            .foregroundStyle(.pcGrayBlue)
                    }
                    .frame(height: 36)
                }
            } header: {
                Label("All Tools", systemImage: "hammer")
            }
        }
        .navigationTitle("Chemistry Tools")
        .environment(\.defaultMinListRowHeight, 36)
    }
}

#Preview {
    ToolsView()
}
