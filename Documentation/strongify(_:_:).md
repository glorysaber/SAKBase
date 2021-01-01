# strongify(\_:\_:)

Takes a target and strongly captures it and runs the given closure body against it.

``` swift
@inlinable public func strongify<Target, Value, ReturnType>(_ target: Target, _ body: @escaping (Target) -> (Value) -> ReturnType) -> (Value) -> ReturnType
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

# strongify(\_:\_:)

Takes a target and strongly captures it and runs the given closure body against it.

``` swift
@inlinable public func strongify<Target>(_ target: Target, _ body: @escaping (Target) -> () -> Void) -> () -> Void
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

# strongify(\_:\_:)

Takes a target and strongly captures it and runs the given closure body against it.

``` swift
@inlinable public func strongify<Target, ReturnType>(_ target: Target, _ body: @escaping (Target) -> () -> ReturnType) -> () -> ReturnType
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

# strongify(\_:\_:)

Takes a target and strongly captures it and runs the given closure body against it.

``` swift
@inlinable public func strongify<Target, Value>(_ target: Target, _ body: @escaping (Target) -> (Value) -> Void) -> (Value) -> Void
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
