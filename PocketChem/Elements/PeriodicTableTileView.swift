//
//  PeriodicTableTileView.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data
import Design
import Tools
import SwiftUI

enum PeriodicTableTileType {
    case empty
    case numberRange(text: String, color: Color)
    case element(element: Element)

    static func type(for tile: (group: Int, row: Int)) -> Self {
        // Check for the number range tiles.
        if tile.row == 6 && tile.group == 3 {
            return .numberRange(text: "57-71", color: .pcLime)
        }
        if tile.row == 7 && tile.group == 3 {
            return .numberRange(text: "89-103", color: .pcGrayBlue)
        }
        // Check for the empty tiles.
        if (tile.row == 1 && (2...17).contains(tile.group)) ||
            ((2...3).contains(tile.row) && (3...12).contains(tile.group)) ||
            ((8...9).contains(tile.row) && [1, 2, 18].contains(tile.group)) {
            return .empty
        }
        // Otherwise, the style should be an element.
        // let elementIndex =
        // 2 8 18 32 32 18 8
        let element = DataStore.shared.elements.first {
            $0.periodicTableGroup == tile.group && $0.periodicTableRow == tile.row
        }!
        return .element(element: element)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGPoint
    static var defaultValue = CGPoint.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.x += nextValue().x
        value.y += nextValue().y
    }
}

struct PeriodicTableTileView: View {

    var element: Element

    @Binding var searchQuery: String
    @Binding var selectedElement: Element?
    @Binding var tileMode: PeriodicTableTileMode

    @State private var animatedAtomicRadius: Bool = false
    @State private var animatedElectronegativity: Bool = false
    @State private var animatedIonizationEnergy: Bool = false

    var body: some View {
        Button {
            self.selectedElement = element
        } label: {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 78, height: 94)
                .foregroundStyle(Color.secondaryGroupedBackground)
                .overlay {
                    ZStack {
                        VStack {
                            switch tileMode {
                            case .group:
                                EmptyView()
                            case .atomicRadius:
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(
                                        element.matchesQuery(query: searchQuery) ? element.color : .secondary
                                    )
                                    .frame(
                                        width: 78,
                                        height: animatedAtomicRadius
                                            ? ((element.atomicRadius ?? 0) / 348.0) * 94
                                            : 0
                                    )
                                    .animation(.linear(duration: 1), value: animatedAtomicRadius)
                                    .onAppear {
                                        animatedAtomicRadius = true
                                    }
                                    .onDisappear {
                                        animatedAtomicRadius = false
                                    }
                            case .electronegativity:
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(
                                        element.matchesQuery(query: searchQuery) ? element.color : .secondary
                                    )
                                    .frame(
                                        width: 78,
                                        height: animatedElectronegativity
                                            ? ((element.electronegativity ?? 0) / 3.98) * 94
                                            : 0
                                    )
                                    .animation(.linear(duration: 1), value: animatedElectronegativity)
                                    .onAppear {
                                        animatedElectronegativity = true
                                    }
                                    .onDisappear {
                                        animatedElectronegativity = false
                                    }
                            case .ionizationEnergy:
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(
                                        element.matchesQuery(query: searchQuery) ? element.color : .secondary
                                    )
                                    .frame(
                                        width: 78,
                                        height: animatedIonizationEnergy
                                            ? ((element.ionizationEnergy ?? 0) / 24.588) * 94
                                            : 0
                                    )
                                    .animation(.linear(duration: 1), value: animatedIonizationEnergy)
                                    .onAppear {
                                        animatedIonizationEnergy = true
                                    }
                                    .onDisappear {
                                        animatedIonizationEnergy = false
                                    }
                            }
                        }
                        .frame(width: 78, height: 94, alignment: .bottom)
                    }
                    VStack {
                        Spacer()
                        Text("\(element.atomicNumber)")
                            .font(.system(size: 9))
                            .bold()
                        Spacer()
                        Text("\(element.symbol)")
                            .font(.system(size: 29))
                            .bold()
                        Spacer()
                        Text("\(element.name)")
                            .font(.system(size: 9))
                        Spacer()
                        Text("\(element.atomicMass.roundedString(to: 3))")
                            .font(.system(size: 7))
                        Spacer()
                    }
                    .foregroundStyle(
                        tileMode == .group
                        ? element.matchesQuery(query: searchQuery)
                            ? element.color
                            : Color.secondary
                        : Color.primary
                    )
                    .fontDesign(.rounded)
                }
        }
    }
}
