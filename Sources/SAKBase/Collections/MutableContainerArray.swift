//
//  MutableContainerArray.swift
//  SAKBase
//
//  Created by Stephen Kac on 6/12/21.
//  Copyright © 2021 Stephen Kac. All rights reserved.
//

import Foundation

public final class MutableContainerArray<ElementContained> {
	public typealias Container = MutableValueReference<ElementContained>

	private var internalArray: [Container]

	public required init() {
		internalArray = []
	}

	public required init<S: Sequence>(_ sequence: S) where S.Element == Container {
		internalArray = sequence.map(\.deepCopy)
	}

	public required init<S: Sequence>(_ sequence: S) where S.Element == ElementContained {
		internalArray = sequence.map { Container($0) }
	}
}

extension MutableContainerArray: Copyable {
	public var deepCopy: Self {
		Self(internalArray.map(\.deepCopy))
	}
}

extension MutableContainerArray: Collection {

	public typealias Iterator = IndexingIterator<MutableContainerArray>

	public typealias Element = Container

	public typealias Index = Int

	public var isEmpty: Bool {
		internalArray.isEmpty
	}

	public var count: Int {
		internalArray.count
	}

	public var first: Element? {
		internalArray.first
	}

	public var startIndex: Index {
		internalArray.startIndex
	}

	public var endIndex: Index {
		internalArray.endIndex
	}

	public subscript(_ position: Index) -> Element {
		get {
			internalArray[position]
		}
		set {
			internalArray[position] = newValue
		}
	}

	public subscript(_ position: Index) -> ElementContained {
		get {
			internalArray[position].wrappedValue
		}
		set {
			internalArray[position].wrappedValue = newValue
		}
	}

	public func index(after index: Index) -> Int {
		internalArray.index(after: index)
	}
}

// MARK: Element Methods

extension MutableContainerArray: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = Element

	public convenience init(arrayLiteral elements: ArrayLiteralElement...) {
		// Swift gets confused if we try to call the Sequence initializer.
		self.init()
		self.internalArray = elements
	}

	public convenience init(arrayLiteral elements: ElementContained...) {
		// Swift gets confused if we try to call the Sequence initializer.
		self.init()
		self.internalArray = elements.map { Container($0) }
	}
}

extension MutableContainerArray: BidirectionalCollection {
	public func index(before index: Int) -> Int {
		internalArray.index(before: index)
	}
}

extension MutableContainerArray: RandomAccessCollection {}

extension MutableContainerArray: Sequence {}

extension MutableContainerArray: RangeReplaceableCollection {
	public func replaceSubrange<C: Collection>(_ subrange: Range<Int>, with newElements: C) where Element == C.Element {
		internalArray.replaceSubrange(subrange, with: newElements)
	}

	public func replaceSubrange<C: Collection>(
		_ subrange: Range<Int>,
		with newElements: C
	) where ElementContained == C.Element {
		guard !newElements.isEmpty else {
			// If the new elements isEmpty we are to remove the given range
			replaceSubrange(subrange, with: [Element]())
			return
		}

		let inScopeRange = subrange.clamped(to: internalArray.indices)
		let outOfScopeRange = subrange.clamped(to: internalArray.endIndex..<subrange.endIndex)

		for (referenceElement, newElement) in zip(internalArray[inScopeRange], newElements) {
			// For each inscope index we just update the given range
			referenceElement.wrappedValue = newElement
		}

		let appendingElements = newElements[newElements.index(newElements.startIndex, offsetBy: inScopeRange.count)...]
		replaceSubrange(outOfScopeRange, with: appendingElements.map(Container.init))
	}
}

extension MutableContainerArray: CustomStringConvertible where ElementContained: CustomStringConvertible {
	public var description: String {
		"[\(map(\.description).joined(separator: ", "))]"
	}
}

extension MutableContainerArray: CustomDebugStringConvertible {
	public var debugDescription: String {
		"\(Self.self)(\(internalArray))"
	}
}
