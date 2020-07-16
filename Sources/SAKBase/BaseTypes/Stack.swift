/*
  Last-in first-out stack (LIFO)

  Push and pop are O(1) operations.
*/
public struct Stack<Element> {
  fileprivate var array = [Element]()

	public init(){}

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func push(_ element: Element) {
    array.append(element)
  }

  public mutating func pop() -> Element? {
    return array.popLast()
  }

  public var top: Element? {
    return array.last
  }

	public mutating func forEachPop(_ body: (Element) throws -> Void) rethrows {
		while let element = pop() {
			try body(element)
		}
	}
}
