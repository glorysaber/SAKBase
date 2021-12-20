//
//  WeakRef.swift
//  SAKBase
//
//  Created by Stephen Kac on 6/13/21.
//  Copyright © 2021 Stephen Kac. All rights reserved.
//

import Foundation

public struct WeakRef<T: AnyObject> {
	public weak var object: T?

	public init(_ object: T?) {
		self.object = object
	}
}
