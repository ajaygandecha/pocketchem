//
//  ElementOfTheDayView.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data
import Design
import Tools
import SwiftUI

struct ElementOfTheDayView: View {

    @State private var elementOfTheDay = DataStore.shared.elementOfTheDay()

    @State private var showElementSheet: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Button {
                            self.showElementSheet.toggle()
                        } label: {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("\(elementOfTheDay.atomicNumber)")
                                        .font(.headline)
                                        .bold()
                                    Spacer()
                                    Text("\(elementOfTheDay.elementClass.rawValue)")
                                        .font(.headline)
                                }
                                .foregroundStyle(elementOfTheDay.color)
                                .padding(.top, 12)

                                HStack(alignment: .bottom, spacing: 12) {
                                    Text("\(elementOfTheDay.symbol)")
                                        .font(.largeTitle)
                                        .bold()
                                    Text("\(elementOfTheDay.name)")
                                        .font(.title2)
                                        .padding(.bottom, 4)
                                }
                                .foregroundStyle(elementOfTheDay.color)

                                Text("\(elementOfTheDay.elementOfTheDayPromo)")
                                    .padding(.bottom, 12)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Label("\(Date.now.formatted(date: .long, time: .omitted))", systemImage: "calendar")
                }

                Section {
                    elementOfTheDayTableView
                }
            }
            .navigationTitle("Element of the Day")
            .sheet(isPresented: $showElementSheet) {
                ElementDetailView(element: self.elementOfTheDay)
                    .fontDesign(.rounded)
            }
        }
    }

    @ViewBuilder
    var elementOfTheDayTableView: some View {

        HStack(alignment: .center) {

            let tableColumns: [GridItem] = Array(repeating: .init(.fixed(8)), count: 18)

            LazyVGrid(columns: tableColumns, alignment: .center, spacing: 4) {
                ForEach((0..<180), id: \.self) { index in

                    if let elementAtPosition = DataStore.shared.elements.first(where: {
                        $0.smallPeriodicTablePosition == index
                    }) {

                        if elementAtPosition == self.elementOfTheDay {
                            Circle()
                                .fill(elementAtPosition.color)
                        } else if elementAtPosition.elementClass == self.elementOfTheDay.elementClass {
                            Circle()
                                .strokeBorder(elementAtPosition.color.opacity(0.85), lineWidth: 1.5)
                        } else {
                            Circle()
                                .strokeBorder(elementAtPosition.color.opacity(0.2), lineWidth: 1.5)
                        }
                    } else {
                        Circle()
                            .hidden()
                    }
                }
            }
        }.padding(.vertical, 24)
    }
}

#Preview {
    ElementOfTheDayView()
}
