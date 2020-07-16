//
//  GroupOperation.swift
//  SAKBase_MacOS
//
// Originally from the site below
// https://medium.com/flawless-app-stories/parallel-programming-with-swift-operations-54cbefaf3cb0
//

import Foundation

//
public class GroupOperation: AsyncOperation {
	let queue = OperationQueue()
	public var operations: [AsyncOperation] = []
	
	public override func execute() {
		queue.addOperations(operations, waitUntilFinished: true)
	}
}
