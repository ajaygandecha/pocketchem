//
//  WarningText.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//  Adapted from: Luduan for iOS
//

import SwiftUI

public struct WarningText: View {

    var icon: WarningTextIcon
    var iconColor: Color
    var text: String

    public init(icon: WarningTextIcon, iconColor: Color, text: String) {
        self.icon = icon
        self.iconColor = iconColor
        self.text = text
    }

    public var body: some View {
        HStack(alignment: .top) {
            WarningIcon(icon: icon, iconColor: iconColor)
            Text(text)
        }
    }
}

public struct WarningIcon: View {
    var icon: WarningTextIcon
    var iconColor: Color

    public var body: some View {
        Image(systemName: icon.rawValue)
            .foregroundColor(iconColor)
            .padding(.top, 1)
    }
}

public enum WarningTextIcon: String {
    case exclamation = "exclamationmark.triangle.fill"
    case info = "info.circle.fill"
    case hammer = "hammer.circle.fill"
    case wave = "hand.wave.fill"
    case checkmark = "checkmark.circle.fill"
    case exclamationCircle = "exclamationmark.circle.fill"
}

#Preview {
    VStack(spacing: 36.0) {
        WarningText(icon: .exclamation, iconColor: .red, text: "This pinyin combination is invalid!")
        WarningText(icon: .exclamation, iconColor: .yellow, text: "This pinyin combination is invalid!")
        WarningText(icon: .info, iconColor: .cyan, text: "This pinyin combination is invalid!")
        WarningText(icon: .hammer, iconColor: .purple, text: "This pinyin combination is invalid!")

    }
}
