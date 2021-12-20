//
//  MutableContainerArray+BidirectionalCollection.swift
//  SAKBase
//
//  Created by Stephen Kac on 6/15/21.
//  Copyright © 2021 Stephen Kac. All rights reserved.
//

import Foundation

extension MutableContainerArray: BidirectionalCollection {
	@inlinable
	public func index(before index: Int) -> Int {
		internalArray.index(before: index)
	}
}
