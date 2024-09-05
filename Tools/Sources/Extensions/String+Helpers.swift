//
//  String+Helpers.swift
// PocketChem
//
//  Created by Ajay Gandecha on 9/2/24.
//

import Foundation

extension String {
    /// Whether or not a string contains special characters.
    public var containsSpecialCharacter: Bool {
      let regex = ".*[^A-Za-z0-9].*"
      let testString = NSPredicate(format: "SELF MATCHES %@", regex)
      return testString.evaluate(with: self)
   }
}
