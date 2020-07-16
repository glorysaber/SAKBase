//
//  File.swift
//  SAKBase
//
//  Created by Stephen Kac on 2/27/18.
//

import RealModule


/// - Parameters:


public extension Real {
	
	/// Returns wether or not the value is within the given episolon of the other value
	/// - Parameters:
	///   - epsilon: The max allowed difference between two values
	///   - realNumber: The value to compare against
	/// - Returns: True if within epsilon of realNumber, false otherwise.
	func within(_ epsilon: Self, of realNumber: Self) -> Bool {
		
		guard (self.isNaN || realNumber.isNaN || epsilon.isNaN) == false  else {
			return false
		}
		
		guard self != realNumber else {
			return true
		}
		
		guard (self.isInfinite || realNumber.isInfinite) == false else {
			return false
		}
		
		guard epsilon.isInfinite == false else {
			return true
		}
		
		let range = (realNumber - epsilon)...(realNumber + epsilon)
		
		return range.contains(self)
	}
}

public protocol EquivalentIntegerSize: BinaryFloatingPoint {
	associatedtype IntegerSize: SignedNumeric & FixedWidthInteger
}

public extension EquivalentIntegerSize {
	
	/// Returns wether or not the value is within the given ulps epsilon of the other value
	/// - Warning: Ulps is not a good way to compare small numbers. 0.1 and 0 has 1000's of ulps of difference
	/// - Parameters:
	///   - ulps: The max allowed difference in ulps between two values
	///   - realNumber: The value to compare against
	/// - Returns: True if within epsilon of realNumber, false otherwise.
	func within<Integer: BinaryInteger>(ulps: Integer, of realNumber: Self) -> Bool {
		precondition(ulps != IntegerSize.max)
		
		let withinUlps = self.distanceInUlps(to: realNumber)
		
		return withinUlps <= ulps
	}
	
	
	/// Gets the distance between floating points in ulps.
	/// - Warning: Ulps is not a good way to compare small numbers. 0.1 and 0 has 1000's of ulps of difference
	/// - Parameter realNumber: The number to compare with
	/// - Returns: the distance in ulps
	func distanceInUlps(to realNumber: Self) -> IntegerSize {
		guard (self.isNaN || realNumber.isNaN) == false else {
			return IntegerSize.max
		}
		
		guard self != realNumber else {
			return 0
		}
		
		guard (self.isInfinite || realNumber.isInfinite) == false else {
			return IntegerSize.max
		}
		
		guard self.sign == realNumber.sign else {
			return IntegerSize.max
		}
		
		let bitcastedFloat = unsafeBitCast(self, to: IntegerSize.self)
		let bitcastedFloatCompared = unsafeBitCast(realNumber, to: IntegerSize.self)
		
		return abs(bitcastedFloat - bitcastedFloatCompared)
	}
}

// MARK: - Conformances

extension Float32: EquivalentIntegerSize {
	public typealias IntegerSize = Int32
}

extension Float64: EquivalentIntegerSize {
	public typealias IntegerSize = Int64
}

#if os(iOS)
@available(iOS 14.0, *)
extension Float16: EquivalentIntegerSize {
	public typealias IntegerSize = Int16
}
#endif
