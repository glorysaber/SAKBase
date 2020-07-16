//
//  Point3.swift
//  SAKBase
//
//  Created by Stephen Kac on 7/16/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import RealModule
import Foundation

/// A Swift protocol for a point in some 2 dimensional container
public protocol Point3: Hashable {
	associatedtype PointValue: SignedNumeric

	var xCord: PointValue { get set }
	var yCord: PointValue { get set }
	var zCord: PointValue { get set }

	init(xCord: PointValue, yCord: PointValue, zCord: PointValue)
}

public extension Point3 where PointValue: Real {
	init(xCord: Int, yCord: Int, zCord: Int) {
		self.init(xCord: PointValue(xCord), yCord: PointValue(yCord), zCord: PointValue(zCord))
	}
}

public extension Point3 {
	static func +=(left: inout Self, right: Self) {
		left = left + right
	}
}

public extension Point3 where PointValue: Real {
	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - epsilon: The max allowed difference between two values
	///   - point: The value to compare against
	/// - Returns: True if within epsilon of point, false otherwise.
	func within(_ epsilon: Self, of point: Self) -> Bool {
		self.xCord.within(epsilon.xCord, of: point.xCord) &&
			self.yCord.within(epsilon.yCord, of: point.yCord)
	}

	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - epsilon: The max allowed difference between two values
	///   - point: The value to compare against
	/// - Returns: True if within epsilon of point, false otherwise.
	func cordsWithin(_ epsilon: Self.PointValue, of point: Self) -> Bool {
		within(Self.init(xCord: epsilon, yCord: epsilon, zCord: epsilon),
									of: point)
	}
}

public extension Point3 where PointValue: Real {
	@available(*, deprecated: 0.0.0, message: "Do not use equivalency with Real types as it will not work as expected, please use within comparisons isntead")
	static func ==(lhs: Self, rhs: Self) -> Bool {
		lhs.xCord == rhs.xCord
			&& lhs.yCord == rhs.yCord
			&& lhs.zCord == rhs.zCord
	}
}

public extension Point3 where PointValue: EquivalentIntegerSize {

	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - ulps: The max allowed difference between two values
	///   - point: The value to compare against
	/// - Returns: True if within epsilon of point, false otherwise.
	func within<PointType: Point3, UlpType: BinaryInteger>(ulps: PointType, of point: Self) -> Bool
	where PointType.PointValue == UlpType {
		return self.xCord.within(ulps: ulps.xCord, of: point.xCord) &&
			self.yCord.within(ulps: ulps.yCord, of: point.yCord)
	}
}


public func +<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord + rhs.xCord, yCord: lhs.yCord + rhs.yCord, zCord: lhs.zCord + rhs.zCord)
}

public func -<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord - rhs.xCord, yCord: lhs.yCord - rhs.yCord, zCord: lhs.zCord - rhs.zCord)
}

public func *<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType {
	return PointType(xCord: lhs.xCord * rhs.xCord, yCord: lhs.yCord * rhs.yCord, zCord: lhs.zCord * rhs.zCord)
}

public func /<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType
where PointType.PointValue: BinaryInteger {
	return PointType(xCord: lhs.xCord / rhs.xCord, yCord: lhs.yCord / rhs.yCord, zCord: lhs.zCord / rhs.zCord)
}

public func /<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType
where PointType.PointValue: BinaryFloatingPoint {
	return PointType(xCord: lhs.xCord / rhs.xCord, yCord: lhs.yCord / rhs.yCord, zCord: lhs.zCord / rhs.zCord)
}

public extension Point3 where PointValue: Real {
	func floored() -> Self {
		let value = Self.init(xCord: floor(xCord), yCord: floor(yCord), zCord: floor(zCord))
		return value
	}
}


