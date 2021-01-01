//
//  Weakify.swift
//  SAKBase
//
//  Created by Stephen Kac on 7/16/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import Foundation

/** Takes a target and weakly runs the given closure against it
Return the default value if nil.

Equivalent to:
```
[weak target] (value: Value) in
 guard let target = target else { return defaultReturn }
return body(target)(value)
}
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - defaultReturn: The value to return if target is nil
///   - body: T
/// - Returns: The body to execute
@inlinable
public func weakify<Target: AnyObject, Value, ReturnType>(
	_ target: Target?,
	default defaultReturn: ReturnType,
	_ body: @escaping (Target) -> ((Value) -> ReturnType)) -> (Value) -> ReturnType {
	return { [weak target] (value: Value) in
		guard let target = target else { return defaultReturn }
		return body(target)(value)
	}
}

/** Takes a target and weakly runs the given closure against it.
If nil, does nothing.

Equivalent to:
```
[weak target] (value: Value) in
guard let target = target else { return }
return body(target)(value)
}
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - body: T
/// - Returns: The body to execute
@inlinable
public func weakify<Target: AnyObject, Value>(
	_ target: Target?,
	_ body: @escaping (Target) -> ((Value) -> Void)) -> (Value) -> Void {
	return { [weak target] (value: Value) in
		guard let target = target else { return }
		return body(target)(value)
	}
}

/** Takes a target and weakly runs the given closure against it.
If nil, does nothing.

Equivalent to:
```
[weak target] in
guard let target = target else { return }
return body()(value)
}
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - body: T
/// - Returns: The body to execute
@inlinable
public func weakify<Target: AnyObject>(
	_ target: Target?,
	_ body: @escaping (Target) -> (() -> Void)) -> () -> Void {
	return { [weak target] in
		guard let target = target else { return }
		return body(target)()
	}
}

/** Takes a target and weakly runs the given closure against it.
If nil, does nothing.

Equivalent to:
```
[weak target] in
guard let target = target else { return }
return body()(value)
}
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - body: T
/// - Returns: The body to execute
@inlinable
public func weakify<Target: AnyObject, ReturnType>(
	_ target: Target?,
	default defaultReturn: ReturnType,
	_ body: @escaping (Target) -> (() -> ReturnType)) -> () -> ReturnType {
	return { [weak target] in
		guard let target = target else { return defaultReturn }
		return body(target)()
	}
}

/** Takes a target and weakly runs the given closure against it.
If nil, does nothing.

Equivalent to:
```
[weak target] in
guard let target = target else { return }
return body()(value)
}
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - body: T
/// - Returns: The body to execute
@inlinable
public func weakify<Target: AnyObject, ReturnType>(
	_ target: Target?,
	default defaultReturn: ReturnType? = nil,
	_ body: @escaping (Target) -> (() -> ReturnType?)) -> () -> ReturnType? {
	return { [weak target] in
		guard let target = target else { return defaultReturn }
		return body(target)()
	}
}

/** Takes a target and weakly runs the given closure against it
Return the default value if nil. If default value is not given, nil will be returned isntead.

Equivalent to:
```
[weak target] (value: Value) in
guard let target = target else { return defaultReturn }
return body(target)(value)
}
```
*/
/// - Parameters:
///   - target: The target to apply the body too
///   - defaultReturn: The value to return if target is nil
///   - body: T
/// - Returns: The body to execute
@inlinable
public func weakify<Target: AnyObject, Value, ReturnType>(
	_ target: Target?,
	default defaultReturn: ReturnType? = nil,
	_ body: @escaping (Target) -> ((Value) -> ReturnType?)) -> (Value) -> ReturnType? {
	return { [weak target] (value: Value) in
		guard let target = target else { return defaultReturn }
		return body(target)(value)
	}
}
