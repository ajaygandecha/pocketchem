//
//  EquationBalancerView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct EquationBalancerView: View {

    @State private var reactantsText: String = ""
    @State private var productsText: String = ""

    @State private var balancedEquation: String?
    @State private var balanceError: ChemicalEquationBalancer.BalanceError?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("""
                        Type in the reactants and products sides of the chemical equation into the respective fields \
                        below. Separate each compound with a \"+\" sign.
                        """)
                        Text("Do not include any charges on compounds.")
                            .foregroundStyle(Color.secondary)

                        Text("Make sure not to include nested parenthesis in your compounds.")
                            .foregroundStyle(Color.secondary)

                        Text("No need to include underscores (__) as placeholders either!")
                            .foregroundStyle(Color.secondary)

                        Text("Ex) Pb(OH)4 + Cu2O")
                            .foregroundStyle(.secondary)
                    }

                    VStack(alignment: .leading) {
                        Text("Reactants")
                            .foregroundStyle(Color.secondary)
                            .bold()

                        TextField("Enter reactants here...", text: $reactantsText)
                    }

                    HStack {
                        Image(systemName: "minus")
                        Text("reacts to produce")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(Color.secondary)

                    VStack(alignment: .leading) {
                        Text("Products")
                            .foregroundStyle(Color.secondary)
                            .bold()

                        TextField("Enter products here...", text: $productsText)
                    }
                } header: {
                    Label("Chemical Equation Balancer", systemImage: "level")
                }

                Section {
                    Button {
                        do {
                            self.balancedEquation = try ChemicalEquationBalancer.balanceChemicalEquation(
                                reactants: self.reactantsText,
                                products: self.productsText
                            )
                        } catch let error as ChemicalEquationBalancer.BalanceError {
                            self.balancedEquation = nil
                            self.balanceError = error
                        } catch {
                            self.balancedEquation = nil
                            self.balanceError = .inputError
                        }
                    } label: {
                        Text("Balance")
                    }
                    .tint(.pcLime)
                    .disabled(reactantsText.isEmpty || productsText.isEmpty)

                    if let error = self.balanceError {
                        switch error {
                        case .inputError:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: "There was an error with your input. Please try again."
                            )
                        case .nonNormalDelimiterError:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: "Please make sure you use parenthesis ( ) as your delimeter for compounds."
                            )
                        case .missingReactantsOrProducts:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: "Missing either reactants or products!"
                            )
                        case .unbalancedError:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: """
                                Either the reactant side or product side is missing elements the other has. \
                                Please check both inputs and try again.
                                """
                            )
                        case .noAnswerError:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcLime,
                                text: "There is no solution for this chemical equation!"
                            )
                        }
                    }
                }

                if let equation = self.balancedEquation {
                    Section {
                        Text(equation)
                            .font(.title3)
                            .bold()
                            .padding(.vertical, 12)
                    } header: {
                        Label("Solution", systemImage: "sparkles")
                    }
                }
            }
            .navigationTitle("Equation Balancer")
        }
    }
}

#Preview {
    EquationBalancerView()
}
