//
//  Strongify.swift
//  SAKBase
//
//  Created by Stephen Kac on 7/16/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import Foundation

/** Takes a target and strongly captures it and runs the given closure body against it.

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
public func strongify<Target, Value, ReturnType>(
	_ target: Target,
	_ body: @escaping (Target) -> (Value) -> ReturnType) -> (Value) -> ReturnType {
	return body(target)
}

/** Takes a target and strongly captures it and runs the given closure body against it.

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
public func strongify<Target>(
	_ target: Target,
	_ body: @escaping (Target) -> () -> Void) -> () -> Void {
	return body(target)
}

/** Takes a target and strongly captures it and runs the given closure body against it.

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
public func strongify<Target, ReturnType>(
	_ target: Target,
	_ body: @escaping (Target) -> () -> ReturnType) -> () -> ReturnType {
	return body(target)
}

/** Takes a target and strongly captures it and runs the given closure body against it.

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
public func strongify<Target, Value>(
	_ target: Target,
	_ body: @escaping (Target) -> (Value) -> Void) -> (Value) -> Void {
	return body(target)
}
