//
//  Point3.swift
//  Dark Ember
//
//  Created by Stephen Kac on 12/29/16.
//  Copyright © 2016 StephenKac. All rights reserved.
//
import GameKit

public protocol Point3: Equatable {
  var x: Double { get set }
  var y: Double { get set }
  var z: Double { get set }
  
  init(x: Double, y: Double, z: Double)
  
  init(x: Int, y: Int, z: Int)
  
  init(x: Float, y: Float, z: Float)
}

extension Point3 {
  static func +=(left: inout Self, right: Self) {
    left = left + right
  }
}

public func ==<Point3Type: Point3>(lhs: Point3Type, rhs: Point3Type) -> Bool {
  return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
}

public func +<Point3Type: Point3>(lhs: Point3Type, rhs: Point3Type) -> Point3Type {
  return Point3Type.init(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
}

public func -<Point3Type: Point3>(lhs: Point3Type, rhs: Point3Type) -> Point3Type {
  return Point3Type.init(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
}

public func *<Point3Type: Point3>(lhs: Point3Type, rhs: Point3Type) -> Point3Type {
  return Point3Type.init(x: lhs.x * rhs.x, y: lhs.y * rhs.y, z: lhs.z * rhs.z)
}

public func /<Point3Type: Point3>(lhs: Point3Type, rhs: Point3Type) -> Point3Type {
  return Point3Type.init(x: lhs.x / rhs.x, y: lhs.y / rhs.y, z: lhs.z / rhs.z)
}

public func floor<Point3Type: Point3>(Point3: Point3Type) -> Point3Type {
  return Point3Type.init(x: floor(Point3.x), y: floor(Point3.x), z: floor(Point3.z))
}
