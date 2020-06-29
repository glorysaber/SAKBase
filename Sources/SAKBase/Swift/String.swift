//
//  String.swift
//  SAKBase
//
//  Created by Stephen Kac on 1/19/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import Foundation

extension String {
  /// Returns the CustomStringConvertible representation of a non-nil value or the default string if nil
  /// - Parameters:
  ///   - describing: The optional to get String
  ///   - defaultValue: The string to return if nil
  public init<T>(describing optional: T?, defaultValue: @autoclosure () -> String) {
    switch optional {
    case .some(let value):
      self = String(describing: value)
    case .none:
      self = defaultValue()
    }
  }
}
