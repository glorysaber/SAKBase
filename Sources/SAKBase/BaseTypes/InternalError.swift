//
//  InternalError.swift
//  
//
//  Created by Stephen Kac on 9/23/21.
//

import Foundation


/// A general error with a message but no expected handling on recievers side
public struct InternalError: Error {
  public let msg: String
  public let file: String
  public let line: Int
  
  public init(msg: String, file: String = #fileID, line: Int = #line) {
    self.msg = msg
    self.file = file
    self.line = line
  }
}

/// - Parameters:
///   - condition: The condition to check for
///   - failureMessage: The message to include on failure
public func throwingPrecondition(_ condition: @autoclosure () -> Bool, failureMessage: @autoclosure () -> String) throws {
  guard condition() else {
    throw InternalError(msg: failureMessage())
  }
}

/// - Parameters:
///   - condition: The condition to check for
///   - failure: The error to throw on failure
public func throwingPrecondition(_ condition: @autoclosure () -> Bool, failure: @autoclosure () -> Error) throws {
  guard condition() else {
    throw failure()
  }
}
