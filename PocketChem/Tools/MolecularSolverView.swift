//
//  MolecularSolverView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data
import Design
import Tools
import SwiftUI

struct MolecularSolverView: View {

    @State private var mass: Double = 0.0
    @State private var empiricalFormula: String = ""

    @State private var solution: Double?
    @State private var solverError: MolecularFormulaSolver.SolverError?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Enter in the empirical formula and the molecular mass below.")

                    VStack(alignment: .leading) {
                        Text("Mass")
                            .foregroundStyle(Color.secondary)
                            .bold()

                        TextField("Enter the molecular mass here...", value: $mass, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }

                    VStack(alignment: .leading) {
                        Text("Empirical Formula")
                            .foregroundStyle(Color.secondary)
                            .bold()

                        TextField("Enter the empirical formula here...", text: $empiricalFormula)
                    }
                }  header: {
                    Label("Molecular Constant Solver", systemImage: "number")
                }

                Section {
                    Button {
                        do {
                            self.solution = try MolecularFormulaSolver.findMolecularFormula(
                                empiricalFormula: self.empiricalFormula,
                                molecularMass: self.mass
                            )
                        } catch let error as MolecularFormulaSolver.SolverError {
                            self.solution = nil
                            self.solverError = error
                        } catch {
                            self.solution = nil
                            self.solverError = .symbolException
                        }
                    } label: {
                        Text("Solve")
                    }
                    .tint(.pcLime)
                    .disabled(self.empiricalFormula.isEmpty)

                    if let error = self.solverError {
                        switch error {
                        case .symbolException:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: "The inputs are invalid. Please try again."
                            )
                        }
                    }
                }

                if let solution = self.solution {
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Molecular Constant: ")
                                .font(.title3)
                                .bold() +
                            Text("\(solution.roundedString(to: 2))")
                                .foregroundStyle(Color.pcLime)
                                .font(.title3)
                                .bold()

                            Text("""
                            This is the molecular constant. Multiply all subscripts in your empirical formula by \
                            this number to get the molecular formula.
                            """)
                                .foregroundStyle(Color.secondary)
                        }

                    } header: {
                        Label("Solution", systemImage: "sparkles")
                    }
                }
            }
            .navigationTitle("Molecular Solver")
        }
    }
}

#Preview {
    MolecularSolverView()
}
