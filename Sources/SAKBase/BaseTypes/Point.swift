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
public protocol Point: Equatable {
	associatedtype PointValue: Real

	var xCord: PointValue { get set}
	var yCord: PointValue { get set}

	init(xCord: PointValue, yCord: PointValue)
}

public extension Point {
	init(xCord: Int, yCord: Int) {
		self.init(xCord: PointValue(xCord), yCord: PointValue(yCord))
	}
}

public extension Point {
	static func +=(left: inout Self, right: Self) {
		left = left + right
	}
}

public extension Point {
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

public func +<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord + rhs.xCord, yCord: lhs.yCord + rhs.yCord)
}

public func -<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord - rhs.xCord, yCord: lhs.yCord - rhs.yCord)
}

public func *<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord * rhs.xCord, yCord: lhs.yCord * rhs.yCord)
}

public func /<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord / rhs.xCord, yCord: lhs.yCord / rhs.yCord)
}

public extension Point {
	func floored() -> Self {
		let value = Self.init(xCord: floor(xCord), yCord: floor(yCord))
		return value
	}
}


