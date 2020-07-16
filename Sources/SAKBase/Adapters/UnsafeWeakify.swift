//
//  UnsafeWeakify.swift
//  SAKBase
//
//  Created by Stephen Kac on 7/16/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import Foundation

/** Takes a target and unsafely runs the given closure against it as if the target is unowned.

Equivalent to:
```
body(target)
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - body: T
/// - Returns: The body to execute
@inlinable
public func unsafeWeakify<Target: AnyObject, Value, ReturnType>(
	_ target: Target,
	_ body: @escaping (Target) -> (Value) -> ReturnType) -> (Value) -> ReturnType {
	return { [unowned target] (value: Value) in
		return body(target)(value)
	}
}

/** Takes a target and unsafely runs the given closure against it as if the target is unowned.

Equivalent to:
```
body(target)
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - body: T
/// - Returns: The body to execute
@inlinable
public func unsafeWeakify<Target: AnyObject, Value>(
	_ target: Target,
	_ body: @escaping (Target) -> (Value) -> Void) -> (Value) -> Void {
	return { [unowned target] (value: Value) in
		return body(target)(value)
	}
}

/** Takes a target and unsafely runs the given closure against it as if the target is unowned.

Equivalent to:
```
body(target)
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - body: T
/// - Returns: The body to execute
@inlinable
public func unsafeWeakify<Target: AnyObject, ReturnType>(
	_ target: Target,
	_ body: @escaping (Target) -> () -> ReturnType) -> () -> ReturnType {
	return { [unowned target] in
		return body(target)()
	}
}
