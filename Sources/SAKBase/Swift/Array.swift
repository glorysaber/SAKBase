//
//  Array.swift
//  SAKBase
//
//  Created by Stephen Kac on 1/18/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//
// Originally Based off of Chris Eidhof. “Advanced Swift.” Apple Books.

import Foundation

extension Array {
	/// Returns the value if it exists at the given index, otherwise nil.
	/// - Parameters:
	///   - guarded: The index to safely get the value from
	public subscript(guarded index: Int) -> Element? {
		guard (startIndex..<endIndex).contains(index) else {
			return nil
		}
		
		return self[index]
	}
}
