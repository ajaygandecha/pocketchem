//
//  Button+Style.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import SwiftUI

/// All types of button styles for the tag style modifier.
public enum TagButtonStyle {
    /// Equivalent to the bordered prominent button style.
    case prominent
    /// Equivalent to the bordered button style.
    case bordered
}

extension Button {

    /// View modifier that enables using the ternary operator to switch between button styles.
    /// - Parameter style: Style to use on the button.
    /// - Returns: Modified button view.
    @ViewBuilder
    public func tagStyle(_ style: TagButtonStyle) -> some View {
        switch style {
        case .prominent:
            self.buttonStyle(BorderedProminentButtonStyle())
        case .bordered:
            self.buttonStyle(BorderedButtonStyle())
        }
    }
}
