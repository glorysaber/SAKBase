//
//  Optional.swift
//  SAKBase
//
//  Created by Stephen Kac on 1/18/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//
// Originally Based off of Chris Eidhof. “Advanced Swift.” Apple Books.

import Foundation

infix operator !!: CastingPrecedence

/// Allows an error message to be states with a failed force unwrap of an optional
/// - Parameters:
///   - wrapped: The optional to unwrap
///   - failureText: The text to include when an optional fails to be unwrapped
public func !! <T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
	if let unwrapped = wrapped { return unwrapped }
	fatalError(failureText())
}
