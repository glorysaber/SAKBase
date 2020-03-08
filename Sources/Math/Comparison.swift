//
//  File.swift
//  SAKBase
//
//  Created by Stephen Kac on 2/27/18.
//


/// Returns wether the two types are equal within the given epsilon
/// - Parameters:
///   - left
///   - right
///   - epislon: Check difference is within this value
public func areFloats<FloatingType: BinaryFloatingPoint>(_ left: FloatingType, _ right: FloatingType, equalWithin epislon: FloatingType) -> Bool {
  return abs(left - right) < epislon
}

