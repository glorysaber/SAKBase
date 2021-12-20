//
//  MutableArrayIterator.swift
//  
//
//  Created by Stephen Kac on 6/14/21.
//

import Foundation

public struct MutableArrayIterator<Element>: IteratorProtocol {

	@usableFromInline
	let mutableArray: MutableArray<Element>

	@usableFromInline
	lazy var currentIndex = mutableArray.startIndex

	@inlinable
	public mutating func next() -> Element? {
		guard currentIndex != mutableArray.endIndex else { return nil }
		defer {
			self.currentIndex = mutableArray.index(after: currentIndex)
		}
		return mutableArray[currentIndex]
	}
}
