//
//  Copyable.swift
//  SAKBase
//
//  Created by Stephen Kac on 6/12/21.
//  Copyright © 2021 Stephen Kac. All rights reserved.
//

import Foundation

public protocol Copyable {
	/// Make a deep copy
	var deepCopy: Self { get }
}

extension MutableValueReference: Copyable {
	public var deepCopy: MutableValueReference<Element> {
		MutableValueReference(wrappedValue)
	}
}
