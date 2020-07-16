//
//  PThread.swift
//  SAKBase_MacOS
//
//  Created by Stephen Kac on 4/11/19.
//  Copyright © 2019 Stephen Kac. All rights reserved.
//

import Foundation

/// Contains wrapper types for C pthread operations
public struct PThread {

	private init() {}

	/// Wrapper for pthread_rwlock_t
	public class ReadWriteLock {
		@usableFromInline
		var theLock = pthread_rwlock_t()

		public init() {
			pthread_rwlock_init(&theLock, nil)
		}

		public func readLock() {
			pthread_rwlock_wrlock(&theLock)
		}

		public func unlock() {
			pthread_rwlock_unlock(&theLock)
		}

		public func readWriteLock() {
			pthread_rwlock_rdlock(&theLock)
		}

		deinit {
			pthread_rwlock_destroy(&theLock)
		}
	}

	/// A wrapper for pthread_mutex_t
	class Mutex {
		@usableFromInline
		var theLock = pthread_mutex_t()

		public init() {
			pthread_mutex_init(&theLock, nil)
		}

		public func lock() {
			pthread_mutex_lock(&theLock)
		}

		public func unlock() {
			pthread_mutex_unlock(&theLock)
		}
		
		deinit {
			pthread_mutex_destroy(&theLock)
		}
	}
}
