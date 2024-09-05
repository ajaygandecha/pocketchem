//
//  FormulaGroupView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Data
import Design
import Tools
import SwiftUI

struct FormulaGroupView: View {

    var formulas: [Formula]

    init(for formulas: [Formula]) {
        self.formulas = formulas
    }

    var body: some View {
        ForEach(formulas, id: \.title) { formula in
            VStack(alignment: .leading, spacing: 8.0) {
                Text(formula.title)
                    .foregroundStyle(Color.secondary)
                    .bold()
                SubSuperScriptText(formula.formula)
            }
        }
    }
}

#Preview {
    List {
        Section {
            FormulaGroupView(for: Formula.formulas)
        }
    }
}
