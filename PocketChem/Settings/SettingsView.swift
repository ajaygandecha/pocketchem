//
//  SettingsView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 8/30/24.
//

import Data
import Design
import Tools
import SwiftUI
import StoreKit

struct SettingsView: View {

    /// Environment variable that provides a function
    /// to open URLs in the device browser.
    @Environment(\.openURL) var openURL

    /// Environment variable that provides a function
    /// to request an App Store review.
    @Environment(\.requestReview) private var requestReview

    @EnvironmentObject var settingsStore: SettingsStore

    var body: some View {
        NavigationStack {
            List {
                optionsSection
                aboutSection
            }
            .navigationTitle("Settings")
        }
        .environment(\.defaultMinListRowHeight, 36)
    }

    @ViewBuilder
    private var optionsSection: some View {

        let defaultElementViewState = Binding {
            settingsStore.defaultElementViewState
        } set: { newValue in
            settingsStore.defaultElementViewState = newValue
        }

        let groupViewOption = Binding {
            settingsStore.groupViewOption
        } set: { newValue in
            settingsStore.groupViewOption = newValue
        }

        Section {
            Picker("Default Element View", selection: defaultElementViewState) {
                ForEach(ElementViewState.allCases, id: \.rawValue) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .frame(height: 36)

            Picker("Group Header Type", selection: groupViewOption) {
                ForEach(GroupViewOption.allCases, id: \.rawValue) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .frame(height: 36)
        } header: {
            Label("Options", systemImage: "slider.horizontal.3")
        }
    }

    @MainActor
    @ViewBuilder
    private var aboutSection: some View {
        Section {
            NavigationLink {
                AboutView()
            } label: {
                Text("About PocketChem")
                    .frame(height: 36)
            }

            Button {
                requestReview()
            } label: {
                NavigationLink {
                    EmptyView()
                } label: {
                    Text("Recommend")
                        .frame(height: 36)
                }
            }
            .buttonStyle(.plain)
        } header: {
            Label("About PocketChem", systemImage: "note.text")
        }
    }
}

#Preview {
    SettingsView()
        .pocketchemSettingsStore()
}
