//
//  ElementsView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 6/19/24.
//

import SwiftUI
import Data
import Design

enum PeriodicTableTileMode {
    case group, atomicRadius, electronegativity, ionizationEnergy
}

struct ElementsView: View {

    @EnvironmentObject var settingsStore: SettingsStore

    @State private var searchQuery: String = ""

    @State private var selectedElement: Element?

    @State private var showElementOfTheDaySheet: Bool = false

    @State private var showColorKeyPopover: Bool = false

    @State private var elementViewState: ElementViewState = .table

    @State private var tileMode: PeriodicTableTileMode = .group

    var body: some View {
            VStack(alignment: .leading) {

                if elementViewState == .table {
                    elementViewStateSelector
                    Spacer()
                }

                switch self.elementViewState {
                case .table:
                    periodicTable
                        .padding(.top, 8)
                        .padding(.leading, 16)
                case .list:
                    elementList
                }

            }
            .navigationTitle("The Periodic Table")
            .searchable(text: self.$searchQuery)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        self.showElementOfTheDaySheet.toggle()
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        self.showColorKeyPopover = true
                    } label: {
                        Image(systemName: "paintpalette")
                    }
                    .popover(isPresented: self.$showColorKeyPopover) {
                        colorKeyPopover
                            .presentationCompactAdaptation(.popover)
                    }
                    Button {
                        switch elementViewState {
                        case .table:
                            self.elementViewState = .list
                        case .list:
                            self.elementViewState = .table
                        }
                    } label: {
                        switch elementViewState {
                        case .table:
                            Image(systemName: "list.bullet")
                        case .list:
                            Image(systemName: "tablecells")
                        }
                    }
                }
            }
            .background(Color.groupedBackground)
            .sheet(item: $selectedElement) { element in
                ElementDetailView(element: element)
                    .fontDesign(.rounded)
            }
            .sheet(isPresented: $showElementOfTheDaySheet) {
                ElementOfTheDayView()
                    .fontDesign(.rounded)
            }
            .onAppear {
                self.elementViewState = settingsStore.defaultElementViewState
            }
            .disabled(showColorKeyPopover)
            .environment(\.defaultMinListRowHeight, 36)
    }

    @State private var offset = CGPoint.zero

    @ViewBuilder
    private var elementViewStateSelector: some View {
        HStack {
            Image(systemName: "eye")
                .foregroundStyle(Color.secondary)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button {
                        self.tileMode = .group
                    } label: {
                        Text("Group")
                    }
                    .tagStyle(tileMode == .group ? .prominent : .bordered)
                    .controlSize(.small)

                    Button {
                        self.tileMode = .atomicRadius
                    } label: {
                        Text("Atomic Radius")
                    }
                    .tagStyle(tileMode == .atomicRadius ? .prominent : .bordered)
                    .controlSize(.small)

                    Button {
                        self.tileMode = .electronegativity
                    } label: {
                        Text("Electronegativity")
                    }
                    .tagStyle(tileMode == .electronegativity ? .prominent : .bordered)
                    .controlSize(.small)

                    Button {
                        self.tileMode = .ionizationEnergy
                    } label: {
                        Text("Ionization Energy")
                    }
                    .tagStyle(tileMode == .ionizationEnergy ? .prominent : .bordered)
                    .controlSize(.small)
                }
            }
        }
        .padding(.horizontal, 16)
    }
    @ViewBuilder
    private var periodicTable: some View {

        HStack(alignment: .top, spacing: 8) {

            // Add the row headers
            VStack(alignment: .leading, spacing: 8) {
                originTile
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(1..<10) { row in
                            rowHeaderTile(row: row)
                                .padding(.top, row == 8 ? 16 : 0)
                        }
                    }
                    .offset(y: offset.y)
                }
                .disabled(true)
            }

            // Add the columm headers
            VStack(alignment: .leading, spacing: 8) {
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 8) {
                        ForEach(1..<19) { group in
                            groupHeaderTile(group: group)
                        }
                    }
                    .offset(x: offset.x)
                }
                .disabled(true)

                ScrollViewReader { _ in
                    ScrollView([.horizontal, .vertical], showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(1..<10) { row in
                                HStack(alignment: .top, spacing: 8) {
                                    ForEach(1..<19) { group in

                                        switch PeriodicTableTileType.type(for: (group, row)) {
                                        case .empty:
                                            blankTile
                                        case let .numberRange(rangeText, color):
                                            rangeTile(text: rangeText, color: color)
                                        case let .element(element):
                                            PeriodicTableTileView(
                                                element: element,
                                                searchQuery: $searchQuery,
                                                selectedElement: $selectedElement,
                                                tileMode: $tileMode
                                            )
                                        }
                                    }
                                }
                                .padding(.top, row == 8 ? 16 : 0)
                            }
                        }
                        .background( GeometryReader { geo in
                            Color.clear
                                .preference(key: ViewOffsetKey.self, value: geo.frame(in: .named("scroll")).origin)
                        })
                        .onPreferenceChange(ViewOffsetKey.self) { value in
                            offset = value
                        }
                    }

                }
                .coordinateSpace(name: "scroll")
            }
        }
    }

    @ViewBuilder
    private var originTile: some View {
        Button {
            //
        } label: {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.secondaryGroupedBackground)
        }
    }

    @ViewBuilder
    private func groupHeaderTile(group: Int) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(Color.secondaryGroupedBackground, lineWidth: 4)
            .frame(width: 78, height: 36)
            .overlay {
                switch settingsStore.groupViewOption {
                case .roman:
                    Text("\(group.romanNumeral)")
                        .foregroundStyle(Color.secondary)
                case .arabic:
                    Text("\(group)")
                        .foregroundStyle(Color.secondary)
                }
            }
    }

    @ViewBuilder
    private func rowHeaderTile(row: Int) -> some View {
        let rowText = row == 8 ? "L" : row == 9 ? "A" : "\(row)"
        RoundedRectangle(cornerRadius: 8)
            .strokeBorder(Color.secondaryGroupedBackground, lineWidth: 4)
            .frame(width: 36, height: 94)
            .overlay {
                Text(rowText)
                    .foregroundStyle(Color.secondary)
            }
    }

    @ViewBuilder
    private var blankTile: some View {
        Rectangle()
            .frame(width: 78, height: 94)
            .opacity(0)
    }

    @ViewBuilder
    private func rangeTile(text: String, color: Color) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: 78, height: 94)
            .foregroundStyle(Color.secondaryGroupedBackground)
            .overlay {
                VStack {
                    Spacer()
                    Text(text)
                        .font(.system(size: 18))
                        .bold()
                    Spacer()
                }
                .foregroundStyle(searchQuery.isEmpty ? color : Color.secondary)
                .fontDesign(.rounded)
            }
    }

    @ViewBuilder
    private var colorKeyPopover: some View {
        VStack(alignment: .leading) {
            ForEach(ElementClassification.allCases, id: \.rawValue) { classification in
                HStack {
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(classification.color)
                    Text(classification.rawValue)
                }
            }
        }
        .padding(16)
    }

    @ViewBuilder
    private var elementList: some View {
        List {
            Section {
                ForEach(
                    DataStore.shared.elements.filter({ $0.matchesQuery(query: searchQuery)}),
                    id: \.atomicNumber
                ) { element in
                    elementListing(for: element)
                }
            } header: {
                Label("All Elements", systemImage: "atom")
            }
        }
    }

    @ViewBuilder
    private func elementListing(for element: Element) -> some View {
        Button {
            self.selectedElement = element
        } label: {
            NavigationLink {
                ElementDetailView(element: element)
            } label: {
                HStack(alignment: .center) {
                    Text("\(element.atomicNumber)")
                        .font(.caption)
                    Text("\(element.symbol)")
                        .font(.headline)
                        .bold()
                    Text("\(element.name)")
                    Spacer()
                    Text("\(element.atomicMass.roundedString(to: 3)) u")
                }
                .foregroundStyle(element.color)
                .frame(height: 36)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ElementsView()
        .pocketchemSettingsStore()
}
