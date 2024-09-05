//
//  ElementDetailView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 8/31/24.
//

import Data
import Design
import Tools
import SwiftUI

enum ElementViewTab: String, CaseIterable, Identifiable {
    case overview, details, isotopes
    var id: Self { self }
}

struct ElementDetailView: View {

    var element: Element
    @State private var selectedTab: ElementViewTab = .overview

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                List {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(self.element.atomicNumber)")
                                .font(.system(size: 28, weight: .light))
                            Spacer()
                            Text("\(self.element.elementClass.rawValue)")
                                .font(.system(size: 28, weight: .light))
                        }
                        .foregroundStyle(self.element.color)
                        Text("\(self.element.symbol)")
                            .foregroundStyle(self.element.color)
                            .font(.system(size: 72, weight: .light))
                        Text("\(self.element.name)")
                            .foregroundStyle(self.element.color)
                            .font(.system(size: 28))

                        HStack {
                            Spacer()
                            if let primary = self.element.flameColor.primary,
                               let secondary = self.element.flameColor.secondary {

                                RoundedRectangle(cornerRadius: 16.0)
                                    .foregroundStyle(Color.secondaryGroupedBackground)
                                    .frame(width: 164, height: 32)
                                    .overlay {
                                        HStack {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 8, height: 8)
                                                    .padding(.top, 6)
                                                    .foregroundStyle(Color(uiColor: secondary))
                                                Image(systemName: "flame.fill")
                                                    .foregroundStyle(Color(uiColor: primary))
                                            }
                                            Text("Flame Color")
                                                .font(.callout)
                                                .foregroundStyle(.primary)
                                        }
                                    }
                                    .padding(.bottom, 12)
                            }

                            if self.element.isRadioactive {
                                RoundedRectangle(cornerRadius: 16.0)
                                    .foregroundStyle(Color.secondaryGroupedBackground)
                                    .frame(width: 164, height: 32)
                                    .overlay {
                                        HStack {
                                            Image(systemName: "diamond.circle.fill")
                                                .foregroundStyle(.pcYellow)
                                            Text("Radioactive")
                                                .font(.callout)
                                                .foregroundStyle(.primary)
                                        }
                                    }
                                    .padding(.bottom, 12)
                            }
                            Spacer()
                        }

                        HStack {
                            Spacer()
                            Picker("Tab", selection: $selectedTab) {
                                ForEach(ElementViewTab.allCases) { tab in
                                    Text(tab.rawValue.capitalized)
                                }
                            }
                            .pickerStyle(.segmented)
                            Spacer()
                        }
                    }
                    .background(Color.groupedBackground)
                    .listRowInsets(EdgeInsets())

                    switch selectedTab {
                    case .overview:
                        overviewTab(geometry: geometry)
                    case .details:
                        detailsTab
                    case .isotopes:
                        isotopesTab
                    }
                }
            }
        }
        .environment(\.defaultMinListRowHeight, 24)
    }

    @ViewBuilder
    private func overviewTab(geometry: GeometryProxy) -> some View {
        Section {
            listItem(header: "Atomic Mass", value: "\(self.element.atomicMass) u")
            listItem(header: "Phase at STP", value: "\(self.element.stpMatterState.rawValue)")
            listItem(header: "Density", value: "\(self.element.density ?? 0) g/cm3")
            listItem(header: "Atomic Radius", value: "\(self.element.atomicRadius ?? 0) pm")
            listItem(header: "Electronegativity", value: "\(self.element.electronegativity ?? 0)")
            listItem(header: "Electron Affinity", value: "\((self.element.electronAffinity ?? 0).roundedString(to: 5))")
            listItem(header: "Oxidation States", value: "\(self.element.oxidationStates ?? "")")
            listItem(header: "Boiling Point", value: "\(self.element.boilingPoint ?? 0)°C")
            listItem(header: "Melting Point", value: "\(self.element.meltingPoint ?? 0)°C")
        } header: {
            Label("Overview", systemImage: "list.bullet")
        }

        Section {
            VStack {
                electronConfigurationDiagram(geometry: geometry)
                    .padding(.top, 16)
                Text("\(self.element.electronConfiguration)")
                    .foregroundStyle(self.element.color)
                    .padding(.vertical, 16)
                    .bold()
            }
        } header: {
            Label("Electron Configuration", systemImage: "atom")
        }
    }

    @ViewBuilder
    private var detailsTab: some View {
        Section {
            listItem(header: "Year Discovered", value: "\(self.element.yearDiscovered)")

        } header: {
            Label("History", systemImage: "calendar")
        }

        Section {
            Text(self.element.history)
        } header: {
            Label("Details", systemImage: "text.quote")
        }

        Section {
            Text(self.element.uses)
        } header: {
            Label("Uses", systemImage: "hammer")
        }
    }

    @ViewBuilder
    private var isotopesTab: some View {
        ForEach(Array(self.element.isotopes.enumerated()), id: \.offset) { index, isotope in
            Section {
                HStack {
                    // Isotope Name
                    SubSuperScriptText(
                        "_{\(isotope.isotopeNumber(with: self.element))}\(self.element.symbol)",
                        bodyFont: .title3,
                        subScriptFont: .body
                    )

                    Divider()

                    // Isotope Facts
                    VStack(alignment: .leading) {
                        Text("Mass")
                            .foregroundStyle(Color.secondary)
                            .bold()
                        Text("\(isotope.mass?.roundedString(to: 4) ?? "--")")
                        Divider()
                        Text("Natural Abundance")
                            .foregroundStyle(Color.secondary)
                            .bold()
                        Text("\(isotope.naturalAbundance?.roundedString(to: 4) ?? "--")")
                        Divider()
                        Text("Half Life")
                            .foregroundStyle(Color.secondary)
                            .bold()
                        Text("\(isotope.halfLife ?? "--")")
                        Divider()
                        Text("Mode of Decay")
                            .foregroundStyle(Color.secondary)
                            .bold()
                        Text("\(isotope.modeOfDecay ?? "--")")
                    }
                    .font(.callout)
                }
            } header: {
                if index == 0 {
                    Label("All Isotopes", systemImage: "atom")
                }
            }
        }
    }

    @ViewBuilder
    private func listItem(header: String, value: String) -> some View {
        HStack {
            Text(header)
            Spacer()
            Text(value)
                .foregroundStyle(self.element.color)
        }
    }

    @ViewBuilder
    private func electronConfigurationDiagram(geometry: GeometryProxy) -> some View {
        let maxDiameter = geometry.size.width - 124
        ZStack(alignment: .center) {
            ForEach(1..<8) { level in
                let levelDiameter = maxDiameter * (1.0/7.0) * CGFloat(level) + 48
                let isLevelFull = self.element.electronShells > level
                let isEmptyLevel = self.element.electronShells < level
                let levelColor = !isEmptyLevel  ? self.element.color : Color.secondary

                Circle()
                    .strokeBorder(levelColor, style: StrokeStyle(lineWidth: 1.0, dash: [4]))
                    .frame(width: levelDiameter, height: levelDiameter)

                // Add electron icons
                let electronShellRange = Element.electronShellRanges[level]!
                let electronSlotsInLevel = electronShellRange.upperBound - electronShellRange.lowerBound + 1
                let occupiedElectronSlots = isLevelFull
                    ? electronSlotsInLevel
                    : self.element.atomicNumber - electronShellRange.lowerBound + 1

                if !isEmptyLevel {
                    ForEach(0..<occupiedElectronSlots + 1, id: \.self) { index in
                        // Calculate the offset of the electron based on
                        let radius: CGFloat = levelDiameter / 2.0
                        let theta: CGFloat = 2.0 * CGFloat.pi * CGFloat(index) /
                            CGFloat(occupiedElectronSlots) - (CGFloat.pi / 2)
                        let xOffset: CGFloat = radius * cos(theta)
                        let yOffset: CGFloat = radius * sin(theta)
                        Circle()
                            .foregroundStyle(self.element.color)
                            .frame(width: 16, height: 16)
                            .offset(x: xOffset, y: yOffset)

                    }
                }
            }

            Circle()
                .foregroundStyle(self.element.color)
                .frame(width: 48, height: 48)
                .overlay {
                    Text(self.element.symbol)
                }
        }
    }
}

#Preview {
    ElementDetailView(element: DataStore.shared.elements[10])
        .fontDesign(.rounded)
}
