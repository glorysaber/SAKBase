//
//  SAKLock.swift
//  SAKBase
//
//  Created by Stephen Kac on 6/18/18.
//

import Foundation

/// A C based Lock with Concurrent read access across threads
final class Lock<T> {
	private var internalValue: T
	
	private var lock = PThread.ReadWriteLock()
	
	init(_ value: T) {
		internalValue = value
	}
	
	/// Allows use to edit the value contained
	/// - Parameter closure:Contains  the logic for editing the given variable
	/// - Warning: Returned value is not thread safe for reference types
	@discardableResult
	public func edit(_ closure: (inout T) -> ()) -> T {
		lock.readWriteLock()
		defer {
			lock.unlock()
		}
		
		closure(&internalValue)
		
		return internalValue
	}
	
	/// Allows use to read the given value
	/// - Warning: Not thread safe for reference types
	/// - Parameter closure:Contains the logic for editign the given variable
	@discardableResult
	public func read(_ closure: (T) -> ()) -> T {
		lock.readLock()
		defer {
			lock.unlock()
		}
		
		closure(internalValue)
		
		return internalValue
	}
	
	/// Returns a copy of the contained value.
	/// -  Warning: NOT thread safe for reference types
	public var value: T {
		lock.readLock()
		defer {
			lock.unlock()
		}
		
		return internalValue
	}
	
	public init(value: T) {
		self.internalValue = value
	}
	
	// Tells codable to ignore NSLock as NSLock is dependant on runtime and does not need to be stored
	private enum CodingKeys : String, CodingKey {
		case internalValue
	}
}

extension Lock: Codable where T: Codable {
	
}
