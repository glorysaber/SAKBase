# weakify(\_:default:\_:)

Takes a target and weakly runs the given closure against it
Return the default value if nil.

``` swift
@inlinable public func weakify<Target: AnyObject, Value, ReturnType>(_ target: Target?, default defaultReturn: ReturnType, _ body: @escaping (Target) -> ((Value) -> ReturnType)) -> (Value) -> ReturnType
```

Equivalent to:

``` 
[weak target] (value: Value) in
 guard let target = target else { return defaultReturn }
return body(target)(value)
}
```

## Parameters

  - target: The target to apply the body too
  - defaultReturn: The value to return if target is nil
  - body: T

## Returns

The body to execute

# weakify(\_:default:\_:)

Takes a target and weakly runs the given closure against it.
If nil, does nothing.

``` swift
@inlinable public func weakify<Target: AnyObject, ReturnType>(_ target: Target?, default defaultReturn: ReturnType, _ body: @escaping (Target) -> (() -> ReturnType)) -> () -> ReturnType
```

Equivalent to:

``` 
[weak target] in
guard let target = target else { return }
return body()(value)
}
```

## Parameters

  - target: The target to apply the body too
  - body: T

## Returns

The body to execute

# weakify(\_:default:\_:)

Takes a target and weakly runs the given closure against it.
If nil, does nothing.

``` swift
@inlinable public func weakify<Target: AnyObject, ReturnType>(_ target: Target?, default defaultReturn: ReturnType? = nil, _ body: @escaping (Target) -> (() -> ReturnType?)) -> () -> ReturnType?
```

Equivalent to:

``` 
[weak target] in
guard let target = target else { return }
return body()(value)
}
```

## Parameters

  - target: The target to apply the body too
  - body: T

## Returns

The body to execute

# weakify(\_:default:\_:)

Takes a target and weakly runs the given closure against it
Return the default value if nil. If default value is not given, nil will be returned isntead.

``` swift
@inlinable public func weakify<Target: AnyObject, Value, ReturnType>(_ target: Target?, default defaultReturn: ReturnType? = nil, _ body: @escaping (Target) -> ((Value) -> ReturnType?)) -> (Value) -> ReturnType?
```

Equivalent to:

``` 
[weak target] (value: Value) in
guard let target = target else { return defaultReturn }
return body(target)(value)
}
```

## Parameters

  - target: The target to apply the body too
  - defaultReturn: The value to return if target is nil
  - body: T

## Returns

The body to execute
