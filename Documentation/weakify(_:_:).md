# weakify(\_:\_:)

Takes a target and weakly runs the given closure against it.
If nil, does nothing.

``` swift
@inlinable public func weakify<Target: AnyObject, Value>(_ target: Target?, _ body: @escaping (Target) -> ((Value) -> Void)) -> (Value) -> Void
```

Equivalent to:

``` 
[weak target] (value: Value) in
guard let target = target else { return }
return body(target)(value)
}
```

## Parameters

  - target: The target to apply the body too
  - body: T

## Returns

The body to execute

# weakify(\_:\_:)

Takes a target and weakly runs the given closure against it.
If nil, does nothing.

``` swift
@inlinable public func weakify<Target: AnyObject>(_ target: Target?, _ body: @escaping (Target) -> (() -> Void)) -> () -> Void
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
