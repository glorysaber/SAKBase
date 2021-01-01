# DisposeContainer

Automatically disposes of a event upon deinit

``` swift
public class DisposeContainer: Disposable
```

## Inheritance

[`Disposable`](./Disposable.md)

## Initializers

### `init(toBeDisposed:)`

``` swift
public init(toBeDisposed: Disposable)
```

#### Parameters

  - toBeDisposed: The object that is to have its dispose called upon deinit

## Methods

### `removeDisposableFromContainer()`

Removes the responsibility of disposing the related class from the container

``` swift
public func removeDisposableFromContainer() -> Disposable?
```

### `dispose()`

Manually disposes of the contained disposable

``` swift
public func dispose()
```
