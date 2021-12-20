//
//  MutableContainerArrayIterator.swift
//  
//
//  Created by Stephen Kac on 6/14/21.
//

import Foundation

public struct MutableContainerArrayIterator<ElementContained>: IteratorProtocol {

	@usableFromInline
	let mutableArray: MutableContainerArray<ElementContained>

	@usableFromInline
	lazy var currentIndex = mutableArray.startIndex

	@inlinable
	public mutating func next() -> MutableContainerArray<ElementContained>.Element? {
		guard currentIndex != mutableArray.endIndex else { return nil }
		defer {
			self.currentIndex = mutableArray.index(after: currentIndex)
		}
		return mutableArray[currentIndex]
	}
}
