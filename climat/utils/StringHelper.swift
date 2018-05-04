//
//  StringHelper.swift
//  climat
//
//  Created by Hugo  Matus on 5/3/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation

public extension String {
  
  func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased() + dropFirst()
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
  
  var isNilOrEmpty: Bool {
    return self.trimmingCharacters(in: .whitespaces).isEmpty
  }
}

extension Optional where Wrapped == String {
  var isNilOrEmpty: Bool {
    return self?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
  }
  
}
