//
//  EmpiricalSolverView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data
import Design
import Tools
import SwiftUI

struct EmpiricalSolverView: View {

    @State private var empiricalSolverInputs: [EmpiricalFormulaSolver.EmpiricalFormulaComponent] = [
        .init(element: DataStore.shared.elements.first, value: 100.0, isPercent: false)
    ]

    @State private var solverError: EmpiricalFormulaSolver.SolverError?

    @State private var solution: String?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("""
                    Type in the percent (or mass totaling to 100) of the element on the left side and select the \
                    element on the right side.
                    """)
                }

                Section {

                    if empiricalSolverInputs.isEmpty {
                        Text("Add a row below.")
                            .foregroundStyle(Color.secondary)
                    } else {
                        ForEach($empiricalSolverInputs) { $input in

                            HStack {
                                TextField("Mass here...", value: $input.value, formatter: NumberFormatter())
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.decimalPad)

                                Picker("Select an element.", selection: $input.element) {
                                    ForEach(DataStore.shared.elements) { element in
                                        Text(element.name)
                                            .tag(element as Element?)
                                    }
                                }
                                .labelsHidden()
                            }

                        }
                        .onDelete { indexSet in
                            empiricalSolverInputs.remove(atOffsets: indexSet)
                        }

                    }

                    Button {
                        self.empiricalSolverInputs.append(
                            .init(element: DataStore.shared.elements.first, value: 0.0, isPercent: false)
                        )
                    } label: {
                        Label("Add row...", systemImage: "plus")
                    }
                }

                Section {
                    Button {
                        do {
                            self.solution = try EmpiricalFormulaSolver.findEmpiricalFormula(
                                for: self.empiricalSolverInputs
                            )
                        } catch let error as EmpiricalFormulaSolver.SolverError {
                            self.solution = nil
                            self.solverError = error
                        } catch {
                            self.solution = nil
                            self.solverError = .percentSumError
                        }
                    } label: {
                        Text("Solve")
                    }
                    .tint(.pcLime)
                    .disabled(self.empiricalSolverInputs.isEmpty)

                    if let error = self.solverError {
                        switch error {
                        case .percentSumError:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: "The masses do not add up to 100."
                            )
                        }
                    }
                }

                if let solution = self.solution {
                    Section {
                        SubSuperScriptText(solution)
                            .bold()
                            .padding(.vertical, 12)
                    } header: {
                        Label("Solution", systemImage: "sparkles")
                    }
                }
            }
            .navigationTitle("Empirical Solver")
            .environment(\.editMode, Binding.constant(.active))
        }
    }
}

#Preview {
    EmpiricalSolverView()
}
