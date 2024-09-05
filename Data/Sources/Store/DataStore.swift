//
//  DataStore.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import SwiftUI

public class DataStore: ObservableObject {

    /// Contains singleton shared instance of the data store.
    public static let shared = DataStore()

    /// Stores all of the elements data.
    public var elements: [Element] = []

    private init() {
        let decoder = JSONDecoder()

        guard let file = Bundle.module.url(forResource: "elements", withExtension: "json") else {
            fatalError("Couldn't find elements file.")
        }

        do {
            self.elements = try decoder.decode([Element].self, from: Data(contentsOf: file))
        } catch let error {
            fatalError("Couldn't load elements data: \(error)")
        }
    }
}

/// Data Store extension to manage the Element of the Day data and selection.
extension DataStore {

    /// Determines the element of the day based on the current date.
    /// - Returns: Element for the given day.
    public func elementOfTheDay() -> Element {
        // Determine which element to show.
        let calendar = Calendar.current
        let dayInYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 1
        let elementIndex = (dayInYear % 118)

        return DataStore.shared.elements[elementIndex]
    }
}

/// View modifier that adds the data store as an environment object.
struct DataStoreViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environmentObject(DataStore.shared)
    }
}

public extension View {
    /// Applies the data store view modifier to the view.
    func pocketchemDataStore() -> some View {
        modifier(DataStoreViewModifier())
    }
}
