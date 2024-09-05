//
//  SubSuperScript.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import SwiftUI

// Rule:
// _{} subscript
// ^{} superscript
// mainFont
// script font
//
public struct SubSuperScriptText: View {
    let inputString: String
    let bodyFont: Font
    let subScriptFont: Font
    let baseLine: CGFloat

    public init(_ input: String, bodyFont: Font = .body, subScriptFont: Font = .caption, baseLine: CGFloat = 4.0) {
        self.inputString = input
        self.bodyFont = bodyFont
        self.subScriptFont = subScriptFont
        self.baseLine = baseLine
    }

    public var body: some View {
        var string = inputString
        var text = Text("")
        // swiftlint:disable shorthand_operator
        while let validIndex = string.firstIndex(where: { (char) -> Bool in  return (char == "_" || char == "^") }) {

            let mySubstringP1 = string[..<validIndex]
            var mySubstringP2 = string[validIndex...]
            text = text + Text(mySubstringP1) // add normal string to text
            // subscript

            if mySubstringP2.count < 3 { // no possible  sub or super
                return text + Text(mySubstringP2).font(bodyFont)
            }

            var subscriptType = mySubstringP2.first!
            mySubstringP2 = mySubstringP2.dropFirst() /// remove ^ _

            var subScriptString = ""
            if mySubstringP2.first != "{" { // not a subscript
                subScriptString.append(String(subscriptType))
                subscriptType = Character(" ") // no subscript
            } else if let subStringIndex = mySubstringP2.firstIndex(where: { $0 == "}" }) {
                mySubstringP2 = mySubstringP2.dropFirst() /// remove {
                subScriptString = String(mySubstringP2[..<subStringIndex])
                mySubstringP2 = mySubstringP2[subStringIndex...].dropFirst() // remove }
            } else {
                return Text("") // not balance string
            }

            switch subscriptType {
            case "^":
                text = text + Text(subScriptString)
                    .font(subScriptFont)
                                  .baselineOffset(baseLine)
            case "_":
                text = text + Text(subScriptString)
                    .font(subScriptFont)
                                  .baselineOffset(-1 * baseLine)
            default:
                text = text + Text(subScriptString).font(bodyFont)
            }
            string = String(mySubstringP2)
        }
        text = text + Text(string).font(bodyFont)
        return text
    }
    // swiftlint:enable shorthand_operator
}

struct SubSuperScriptText_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Chemistry").font(.title3).padding([.top, .bottom])
                SubSuperScriptText("2NaOH + H_{2}SO_{4} → 2H_{2}O + Na_{2}SO_{4}")
                Text("Maths").font(.title3).padding([.top, .bottom])
                SubSuperScriptText("x^{2} + 20x + 100 = 0", bodyFont: .callout, subScriptFont: .caption)
                SubSuperScriptText("x^{2} + 10x + 10x + 100 = 0", bodyFont: .callout, subScriptFont: .caption)
                SubSuperScriptText("x(x + 10) + 10(x + 10) = 0", bodyFont: .callout, subScriptFont: .caption)
                SubSuperScriptText("(x + 10)(x + 10) = 0", bodyFont: .callout, subScriptFont: .caption)
                SubSuperScriptText("x = -10", bodyFont: .callout, subScriptFont: .caption)
                SubSuperScriptText("Demo^{TM}", bodyFont: .callout, subScriptFont: .caption)
                Spacer()
            }.padding([.leading, .trailing])
        }
    }
}
