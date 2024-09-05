//
//  ContentView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data
import SwiftUI

enum Tab: CaseIterable, Identifiable {
    var id: Self { self }
    case elements, tools, reference, settings
}

struct ContentView: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selectedTab: Tab? = .elements

    var body: some View {
        if self.horizontalSizeClass == .compact {
            TabView {
                ElementsView()
                    .tabItem { Label("Elements", systemImage: "flask") }

                ToolsView()
                    .tabItem { Label("Tools", systemImage: "wrench.and.screwdriver") }

                ReferenceView()
                    .tabItem {  Label("Reference", systemImage: "book") }

                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape") }
            }
        } else {
            NavigationSplitView {
                List(Tab.allCases, selection: $selectedTab) { tab in
                    switch tab {
                    case .elements:
                        Label("Elements", systemImage: "flask")
                    case .tools:
                        Label("Tools", systemImage: "wrench.and.screwdriver")
                    case .reference:
                        Label("Reference", systemImage: "book")
                    case .settings:
                        Label("Settings", systemImage: "gearshape")
                    }
                }
                .navigationTitle("PocketChem")
            } detail: {
                switch selectedTab {
                case .elements:
                    ElementsView()
                case .tools:
                    ToolsView()
                case .reference:
                    ReferenceView()
                case .settings:
                    SettingsView()
                case .none:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .pocketchemDataStore()
        .pocketchemSettingsStore()
        .fontDesign(.rounded)
}
