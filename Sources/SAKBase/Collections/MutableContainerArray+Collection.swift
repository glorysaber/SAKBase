//
//  MutableContainerArray+Collection.swift
//  SAKBase
//
//  Created by Stephen Kac on 6/15/21.
//  Copyright © 2021 Stephen Kac. All rights reserved.
//

import Foundation

extension MutableContainerArray: Collection {

	public typealias Iterator = MutableContainerArrayIterator<ElementContained>

	public typealias Element = Container

	public typealias Index = Int

	public func makeIterator() -> Iterator {
		Iterator(mutableArray: self)
	}

	@inlinable
	public var isEmpty: Bool {
		internalArray.isEmpty
	}

	@inlinable
	public var count: Int {
		internalArray.count
	}

	@inlinable
	public var first: Element? {
		internalArray.first
	}

	@inlinable
	public var startIndex: Index {
		internalArray.startIndex
	}

	@inlinable
	public var endIndex: Index {
		internalArray.endIndex
	}

	@inlinable
	public subscript(_ position: Index) -> Element {
		get {
			internalArray[position]
		}
		set {
			internalArray[position] = newValue
		}
	}

	@inlinable
	public subscript(_ position: Index) -> ElementContained {
		get {
			internalArray[position].wrappedValue
		}
		set {
			internalArray[position].wrappedValue = newValue
		}
	}

	@inlinable
	public func index(after index: Index) -> Int {
		internalArray.index(after: index)
	}
}
