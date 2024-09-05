//
//  PocketChemApp.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data
import SwiftUI

@main
struct PocketChemApp: App {

    /// Stores the global data store and passes it to all views
    @ObservedObject var dataStore = DataStore.shared

    /// Stores the global settings stores and passes it to all views
    @ObservedObject var settingsStore = SettingsStore.shared

    init() {
        configureRoundedFonts()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataStore)
                .environmentObject(settingsStore)
                .fontDesign(.rounded)
                .accentColor(.pcSky)
        }
    }

    func configureRoundedFonts() {
        // Configure rounded fonts on all navigation titles.
        var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle) /// the default large title font
        titleFont = UIFont(
            descriptor:
                titleFont.fontDescriptor
                .withDesign(.rounded)? /// make rounded
                .withSymbolicTraits(.traitBold) /// make bold
                ??
                titleFont.fontDescriptor, /// return the normal title if customization failed
            size: titleFont.pointSize
        )
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont]
    }
}
