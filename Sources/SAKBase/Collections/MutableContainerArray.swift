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

	@usableFromInline
	internal var internalArray: ContiguousArray<Container>

	@inlinable
	public required init() {
		internalArray = []
	}

	@inlinable
	public required init<S: Sequence>(_ sequence: S) where S.Element == Container {
		internalArray = ContiguousArray(sequence.map(\.deepCopy))
	}

	@inlinable
	public required init<S: Sequence>(_ sequence: S) where S.Element == ElementContained {
		internalArray = ContiguousArray(sequence.map(Container.init))
	}
}

extension MutableContainerArray: Copyable {
	@inlinable
	public var deepCopy: Self {
		Self(internalArray.map(\.deepCopy))
	}
}

// MARK: Element Methods

extension MutableContainerArray: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = Element

	@inlinable
	public convenience init(arrayLiteral elements: ArrayLiteralElement...) {
		// Swift gets confused if we try to call the Sequence initializer.
		self.init()
		self.internalArray = ContiguousArray(elements)
	}

	@inlinable
	public convenience init(arrayLiteral elements: ElementContained...) {
		// Swift gets confused if we try to call the Sequence initializer.
		self.init()
		self.internalArray = ContiguousArray(elements.map { Container($0) })
	}
}

extension MutableContainerArray: RandomAccessCollection {}

extension MutableContainerArray: Sequence {}

extension MutableContainerArray: RangeReplaceableCollection {
	@inlinable
	public func replaceSubrange<C: Collection>(_ subrange: Range<Int>, with newElements: C) where Element == C.Element {
		internalArray.replaceSubrange(subrange, with: newElements)
	}

	@inlinable
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

		internalArray.withUnsafeBufferPointer { unsafeArray in
			for (referenceElement, newElement) in zip(unsafeArray[inScopeRange], newElements) {
				// For each inscope index we just update the given range
				referenceElement.wrappedValue = newElement
			}
		}

		let appendingElements = newElements[newElements.index(newElements.startIndex, offsetBy: inScopeRange.count)...]
		replaceSubrange(outOfScopeRange, with: appendingElements.map(Container.init))
	}
}

extension MutableContainerArray: CustomStringConvertible where ElementContained: CustomStringConvertible {
	@inlinable
	public var description: String {
		"[\(map(\.description).joined(separator: ", "))]"
	}
}

extension MutableContainerArray: CustomDebugStringConvertible {
	@inlinable
	public var debugDescription: String {
		"\(Self.self)(\(internalArray))"
	}
}
