//
//  MutableArray.swift
//  SAKECS
//
//  Created by Stephen Kac on 2/13/21.
//  Copyright © 2021 Stephen Kac. All rights reserved.
//

import Foundation

/// Acts like an array but allows structs to be mutable if declared in a variable with COW semantics.
public struct MutableArray<Element> {
	public typealias Container = MutableValueReference<Element>
	private var mutableArray = MutableContainerArray<Element>()

	public init() {
		mutableArray = []
	}

	public init<S: Sequence>(_ sequence: S) where S.Element == Element {
		mutableArray = MutableContainerArray(sequence)
	}

	public mutating func modifying<T>(
		with modifyingClosure: (inout MutableContainerArray<Element>) throws -> T
	) rethrows -> T {
		makeSureIsUniquelyReferenced()
		defer {
			// Make sure the mutableArray was not copied elsewhere.
			makeSureIsUniquelyReferenced()
		}
		return try modifyingClosure(&mutableArray)
	}

	public mutating func unsafelyModifyingSharedSource<T>(
		with modifyingClosure: (inout MutableContainerArray<Element>
		) throws -> T) rethrows -> T {
		try modifyingClosure(&mutableArray)
	}
}

// MARK: - Element
// MARK: Collection
extension MutableArray: Collection {

	public typealias Iterator = IndexingIterator<Self>

	public typealias Index = Int

	public var isEmpty: Bool {
		mutableArray.isEmpty
	}

	public var count: Int {
		mutableArray.count
	}

	public var first: Element? {
		mutableArray.first?.wrappedValue
	}

	public var startIndex: Index {
		mutableArray.startIndex
	}

	public var endIndex: Index {
		mutableArray.endIndex
	}

	public subscript(_ position: Index) -> Element {
		get {
			mutableArray[position].wrappedValue
		}
		set {
			makeSureIsUniquelyReferenced()
			mutableArray[position].wrappedValue = newValue
		}
	}

	public func index(after index: Index) -> Int {
		mutableArray.index(after: index)
	}
}

extension MutableArray: RandomAccessCollection {}

extension MutableArray: Sequence {}

extension MutableArray: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = Element

	public init(arrayLiteral elements: ArrayLiteralElement...) {
		mutableArray = MutableContainerArray(elements.map { Container($0) })
	}
}

extension MutableArray: BidirectionalCollection {
	public func index(before index: Int) -> Int {
		mutableArray.index(before: index)
	}
}

extension MutableArray: RangeReplaceableCollection {
	public mutating func replaceSubrange<C: Collection>(
		_ subrange: Range<Int>,
		with newElements: C
	) where Element == C.Element {
		makeSureIsUniquelyReferenced()
		mutableArray.replaceSubrange(subrange, with: newElements)
	}
}

extension MutableArray: CustomStringConvertible where Element: CustomStringConvertible {
	public var description: String {
		"[\(map(\.description).joined(separator: ", "))]"
	}
}

extension MutableArray: CustomDebugStringConvertible {
	public var debugDescription: String {
		"\(Self.self)(\(mutableArray))"
	}
}

// MARK: - Uniqueness
public extension MutableArray {
	/// Call this function to make sure we are uniquely referenced before making mutating changes.
	mutating func makeSureIsUniquelyReferenced() {
		guard isEmpty == false else { return }

		if !isKnownUniquelyReferenced(&mutableArray) {
			mutableArray = mutableArray.deepCopy
		}
	}
}
