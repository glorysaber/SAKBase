# unsafeWeakify(\_:\_:)

Takes a target and unsafely runs the given closure against it as if the target is unowned.

``` swift
@inlinable public func unsafeWeakify<Target: AnyObject, Value, ReturnType>(_ target: Target, _ body: @escaping (Target) -> (Value) -> ReturnType) -> (Value) -> ReturnType
```

Equivalent to:

``` 
body(target)
```

## Parameters

  - target: The target to apply the body too
  - body: T

## Returns

The body to execute

# unsafeWeakify(\_:\_:)

Takes a target and unsafely runs the given closure against it as if the target is unowned.

``` swift
@inlinable public func unsafeWeakify<Target: AnyObject, Value>(_ target: Target, _ body: @escaping (Target) -> (Value) -> Void) -> (Value) -> Void
```

Equivalent to:

``` 
body(target)
```

## Parameters

  - target: The target to apply the body too
  - body: T

## Returns

The body to execute

# unsafeWeakify(\_:\_:)

Takes a target and unsafely runs the given closure against it as if the target is unowned.

``` swift
@inlinable public func unsafeWeakify<Target: AnyObject, ReturnType>(_ target: Target, _ body: @escaping (Target) -> () -> ReturnType) -> () -> ReturnType
```

Equivalent to:

``` 
body(target)
```

## Parameters

  - target: The target to apply the body too
  - body: T

## Returns

The body to execute
