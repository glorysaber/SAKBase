//
//  Point.swift
//  Dark Ember
//
//  Created by Stephen Kac on 12/25/16.
//  Copyright © 2016 StephenKac. All rights reserved.
//

import RealModule
import Foundation

/// A Swift protocol for a point in some 2 dimensional container
public protocol Point: Hashable {
	associatedtype PointValue: SignedNumeric

	var xCord: PointValue { get set }
	var yCord: PointValue { get set }

	init(xCord: PointValue, yCord: PointValue)
}

public extension Point where PointValue: Real {
	init(xCord: Int, yCord: Int) {
		self.init(xCord: PointValue(xCord), yCord: PointValue(yCord))
	}
}

public extension Point {
	// swiftlint:disable shorthand_operator
	static func += (left: inout Self, right: Self) {
		left = left + right
	}

	static func -= (left: inout Self, right: Self) {
		left = left - right
	}

	static func *= (left: inout Self, right: Self) {
		left = left * right
	}
	// swiftlint:enable shorthand_operator
}

public extension Point where PointValue: Real {
	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - epsilon: The max allowed difference between two values
	///   - point: The value to compare against
	/// - Returns: True if within epsilon of point, false otherwise.
	func within(_ epsilon: Self, of point: Self) -> Bool {
		return self.xCord.within(epsilon.xCord, of: point.xCord) &&
			self.yCord.within(epsilon.yCord, of: point.yCord)
	}

	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - epsilon: The max allowed difference between two values
	///   - point: The value to compare against
	/// - Returns: True if within epsilon of point, false otherwise.
	func cordsWithin(_ epsilon: Self.PointValue, of point: Self) -> Bool {
		return within(Self.init(xCord: epsilon, yCord: epsilon),
									of: point)
	}
}

public extension Point where PointValue: Real {
	@available(*,
	deprecated: 0.0.0,
	message:
	"""
	Do not use equivalency with Real types as
	"it will not work as expected, please use within comparisons isntead
	""")
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.xCord == rhs.xCord && lhs.yCord == rhs.yCord
	}
}

public extension Point where PointValue: EquivalentIntegerSize {

	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - ulps: The max allowed difference between two values
	///   - point: The value to compare against
	/// - Returns: True if within epsilon of point, false otherwise.
	func within<PointType: Point, UlpType: BinaryInteger>(ulps: PointType, of point: Self) -> Bool
	where PointType.PointValue == UlpType {
		return self.xCord.within(ulps: ulps.xCord, of: point.xCord) &&
			self.yCord.within(ulps: ulps.yCord, of: point.yCord)
	}
}

public func +<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord + rhs.xCord, yCord: lhs.yCord + rhs.yCord)
}

public func -<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord - rhs.xCord, yCord: lhs.yCord - rhs.yCord)
}

public func *<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord * rhs.xCord, yCord: lhs.yCord * rhs.yCord)
}

public  extension Point where PointValue: BinaryInteger {
	static func / (lhs: Self, rhs: Self) -> Self {
		return Self(xCord: lhs.xCord / rhs.xCord, yCord: lhs.yCord / rhs.yCord)
	}

	// swiftlint:disable shorthand_operator
	static func /= (left: inout Self, right: Self) {
		left = left / right
	}
	// swiftlint:enable shorthand_operator
}

public  extension Point where PointValue: BinaryFloatingPoint {
	static func / (lhs: Self, rhs: Self) -> Self {
		return Self(xCord: lhs.xCord / rhs.xCord, yCord: lhs.yCord / rhs.yCord)
	}

	// swiftlint:disable shorthand_operator
	static func /= (left: inout Self, right: Self) {
		left = left / right
	}
	// swiftlint:enable shorthand_operator
}

public extension Point where PointValue: Real {
	func floored() -> Self {
		let value = Self.init(xCord: floor(xCord), yCord: floor(yCord))
		return value
	}
}
