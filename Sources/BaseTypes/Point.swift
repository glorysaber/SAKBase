//
//  Point.swift
//  Dark Ember
//
//  Created by Stephen Kac on 12/25/16.
//  Copyright © 2016 StephenKac. All rights reserved.
//

// A Swift protocol for a point in some 2 dimensional container
public protocol Point: Equatable {
    var x: Double { get set }
    var y: Double { get set }
    
    init(x: Float, y: Float)
    
    init(x: Int, y: Int)
    
    init(x: Double, y: Double)
}

public extension Point {
    static func +=(left: inout Self, right: Self) {
        left = left + right
  }
}

public func ==<PointType: Point>(lhs: PointType, rhs: PointType) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

public func +<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
    return PointType(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func -<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
    return PointType(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func *<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
    return PointType(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

public func /<PointType: Point>(lhs: PointType, rhs: PointType) -> PointType {
    return PointType(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}

extension Point {
  func floored() -> Self {
    let value = Self(x: floor(self.x), y: floor(self.y))
    return value
  }
}


