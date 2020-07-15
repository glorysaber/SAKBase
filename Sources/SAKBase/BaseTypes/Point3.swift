//
//  Point3.swift
//  Dark Ember
//
//  Created by Stephen Kac on 12/29/16.
//  Copyright © 2016 StephenKac. All rights reserved.
//
import RealModule
import Foundation

/// A Swift protocol for a point in some 2 dimensional container
public protocol Point3: Equatable {
	associatedtype PointValue: Real

	var xCord: PointValue { get set}
	var yCord: PointValue { get set}
	var zCord: PointValue { get set}

	init(xCord: PointValue, yCord: PointValue, zCord: PointValue)
}

public extension Point3 {
	init(xCord: Int, yCord: Int, zCord: Int) {
		self.init(xCord: PointValue(xCord), yCord: PointValue(yCord), zCord: PointValue(zCord))
	}
}

public extension Point3 {
	static func +=(left: inout Self, right: Self) {
		left = left + right
	}
}

public extension Point3 {
	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - epsilon: The max allowed difference between two values
	///   - point: The value to compare against
	/// - Returns: True if within epsilon of point, false otherwise.
	func within(_ epsilon: Self, of point: Self) -> Bool {
		xCord.within(epsilon.xCord, of: point.xCord) &&
			yCord.within(epsilon.yCord, of: point.yCord) &&
			zCord.within(epsilon.zCord, of: point.zCord)
	}

	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - epsilon: The max allowed difference between two values
	///   - point: The value to compare against
	/// - Returns: True if within epsilon of point, false otherwise.
	func cordsWithin(_ epsilon: Self.PointValue, of point: Self) -> Bool {
		return within(Self.init(xCord: epsilon, yCord: epsilon, zCord: epsilon),
									of: point)
	}
}

public func +<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType {
	PointType(xCord: lhs.xCord + rhs.xCord, yCord: lhs.yCord + rhs.yCord, zCord: lhs.zCord + rhs.zCord)
}

public func -<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType {
	PointType(xCord: lhs.xCord - rhs.xCord, yCord: lhs.yCord - rhs.yCord, zCord: lhs.zCord - rhs.zCord)
}

public func *<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType {
	PointType(xCord: lhs.xCord * rhs.xCord, yCord: lhs.yCord * rhs.yCord, zCord: lhs.zCord * rhs.zCord)
}

public func /<PointType: Point3>(lhs: PointType, rhs: PointType) -> PointType {
	PointType(xCord: lhs.xCord / rhs.xCord, yCord: lhs.yCord / rhs.yCord, zCord: lhs.yCord / rhs.yCord)
}

public extension Point3 {
	func floored() -> Self {
		Self.init(xCord: floor(xCord), yCord: floor(yCord), zCord: floor(zCord))
	}
}
