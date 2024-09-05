//
//  SignificantFiguresView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct SignificantFiguresView: View {

    @State private var calculatorInput: String = ""
    @State private var calculatorSolution: SignificantFigureCalculator.Solution?
    @State private var calculatorError: SignificantFigureCalculator.CalculationError?

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("In any given number, its significant figures include the following:")

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            Text("1.")
                            Text("Any non-zero digit.")
                        }
                        HStack(alignment: .top) {
                            Text("2.")
                            Text("Zeroes between non-zero digits.")
                        }
                        HStack(alignment: .top) {
                            Text("3.")
                            Text("Trailing zeroes only if a decimal point exists.")
                        }
                    }
                    .foregroundStyle(Color.secondary)
                } header: {
                    Label("Significant Figure Rules", systemImage: "list.number")
                }

                Section {
                    Text("Enter in a number below to determine how many significant figures the number has.")
                    TextField("Enter a number here...", text: $calculatorInput)
                        .keyboardType(.decimalPad)
                        .textInputAutocapitalization(.never)
                } header: {
                    Label("Significant Figures Calculator", systemImage: "candybarphone")
                }

                Section {
                    Button {
                        do {
                            self.calculatorSolution = try SignificantFigureCalculator.calculateSignificantFigures(
                                for: self.calculatorInput
                            )
                        } catch let error as SignificantFigureCalculator.CalculationError {
                            self.calculatorSolution = nil
                            self.calculatorError = error
                        } catch {
                            self.calculatorSolution = nil
                            self.calculatorError = .unexpectedIssue
                        }
                    } label: {
                        Text("Calculate")
                    }
                    .tint(.pcLime)
                    .disabled(calculatorInput.isEmpty)

                    if let error = self.calculatorError {
                        switch error {
                        case .tooManyPeriods:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: "Your number should include a maximum of one period in it."
                            )
                        case .containsNotAcceptedCharacters:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: "The inputted number is not valid."
                            )
                        case .unexpectedIssue:
                            WarningText(
                                icon: .exclamation,
                                iconColor: .pcMagenta,
                                text: "An unexpected issue occurred. Please try again."
                            )
                        }
                    }
                }

                if let solution = self.calculatorSolution {
                    Section {
                        VStack(alignment: .leading) {
                            HStack(spacing: 1) {
                                ForEach(Array(solution.string.enumerated()), id: \.offset) { index, character in
                                    Text("\(character)")
                                        .foregroundStyle(
                                            solution.locationsOfSigFigs.contains(index) ? Color.pcLime : Color.primary
                                        )
                                        .font(.title2)
                                        .bold()
                                }
                            }
                            .padding(.vertical, 12)

                            (Text("contains ") +
                            Text("\(solution.numberOfSigFigs)")
                                .foregroundStyle(Color.pcLime)
                                .bold() +
                            Text(" significant figures."))
                                .padding(.vertical, 6)

                            WarningText(
                                icon: .info,
                                iconColor: .pcSky,
                                text: """
                                If your number is a provided constant or a conversion factor, then the value has an \
                                infinite number of significant figures.
                                """
                            )
                                .font(.callout)
                        }
                    } header: {
                        Label("Solution", systemImage: "sparkles")
                    }
                }
            }
            .navigationTitle("Find Significant Figures")
        }
    }
}

#Preview {
    SignificantFiguresView()
}
