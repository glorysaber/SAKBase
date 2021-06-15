//
//  MutableValueReference.swift
//  SAKECS
//
//  Created by Stephen Kac on 2/11/21.
//  Copyright © 2021 Stephen Kac. All rights reserved.
//

import Foundation

public final class MutableValueReference<Element> {
	public var wrappedValue: Element

	@inlinable
	public init(_ value: Element) {
		self.wrappedValue = value
	}
}

extension MutableValueReference: CustomStringConvertible {
	@inlinable
	public var description: String {
		"\(wrappedValue)"
	}
}

extension MutableValueReference: CustomDebugStringConvertible {
	@inlinable
	public var debugDescription: String {
		"\(Self.self)(\(description))"
	}
}
