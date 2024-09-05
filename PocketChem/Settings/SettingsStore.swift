//
//  SettingsStore.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import SwiftUI
import CloudStorage

public enum ElementViewState: String, CaseIterable {
    case table = "Periodic Table"
    case list = "List"
}

public enum GroupViewOption: String, CaseIterable {
    case roman = "Roman"
    case arabic = "Arabic"
}

public class SettingsStore: ObservableObject {

    public static let shared = SettingsStore()

    @CloudStorage("defaultTableView") private var storageDefaultElementViewState: String?

    public var defaultElementViewState: ElementViewState {
        get {
            return ElementViewState(rawValue: self.storageDefaultElementViewState ?? "") ?? .table
        }
        set {
            self.storageDefaultElementViewState = newValue.rawValue
        }
    }

    @CloudStorage("groupViewOption") private var storageGroupViewOption: String?

    public var groupViewOption: GroupViewOption {
        get {
            return GroupViewOption(rawValue: self.storageGroupViewOption ?? "") ?? .roman
        }
        set {
            self.storageGroupViewOption = newValue.rawValue
        }
    }

    private init() { /* Ensures singleton property */ }
}

struct SettingsStoreViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .environmentObject(SettingsStore.shared)
    }
}

public extension View {
    /// View modifier that adds the user's settings store as an environment object.
    func pocketchemSettingsStore() -> some View {
        modifier(SettingsStoreViewModifier())
    }
}
