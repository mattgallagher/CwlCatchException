//
//  CwlCatchExceptionTests.swift
//  CwlPreconditionTesting
//
//  Created by Matt Gallagher on 11/2/16.
//  Copyright © 2016 Matt Gallagher ( https://www.cocoawithlove.com ). All rights reserved.
//
//  Permission to use, copy, modify, and/or distribute this software for any
//  purpose with or without fee is hereby granted, provided that the above
//  copyright notice and this permission notice appear in all copies.
//
//  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
//  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
//  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
//  SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
//  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
//  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
//  IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
//

import XCTest
import CwlCatchException
#if SWIFT_PACKAGE || COCOAPODS
import CwlCatchExceptionSupport
#endif

class TestException: NSException, @unchecked Sendable {
	static var name: String = "com.cocoawithlove.TestException"
	init(userInfo: [AnyHashable: Any]? = nil) {
		super.init(name: NSExceptionName(rawValue: TestException.name), reason: nil, userInfo: userInfo)
	}
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}

class CatchExceptionTests: XCTestCase {
	func test_when_exception_raised_then_catchexception_returns_exception() {
		let exception = TestException.catchException {
			TestException(userInfo: [NSLocalizedFailureReasonErrorKey: "Reason"]).raise()
		}
		XCTAssertEqual(exception?.name, NSExceptionName(rawValue: TestException.name))
	}
	
	func test_when_exception_raised_of_other_type_then_catchexception_returns_nil() {
		var inner: TestException?
		let outer = NSException.catchException {
			inner = TestException.catchException {
				NSException(name: NSExceptionName.rangeException, reason: nil, userInfo: nil).raise()
			}
		}
		XCTAssertNil(inner)
		XCTAssertNotNil(outer)
	}
	
	func test_when_no_exception_raised_then_catchexception_returns_nil() {
		let exception = TestException.catchException {
		}
		XCTAssertNil(exception)
	}
	
	func test_when_exception_raised_then_catchexceptionaserror_throws_exceptionerror() throws {
		let exception = TestException(userInfo: [NSLocalizedFailureReasonErrorKey: "Reason"])
		do {
			try catchExceptionAsError {
				exception.raise()
			}
		} catch let error as ExceptionError {
			XCTAssertEqual(error.exception, exception)
			XCTAssertEqual(error.errorUserInfo[NSLocalizedFailureReasonErrorKey] as? String, "Reason")
		}
	}
	
	func test_when_exception_raised_then_catchexceptionaserror_throws_exceptionerror_no_userinfo() throws {
		let exception = TestException(userInfo: nil)
		do {
			try catchExceptionAsError {
				exception.raise()
			}
		} catch let error as ExceptionError {
			XCTAssertEqual(error.exception, exception)
			XCTAssertNotNil(error.errorUserInfo)
			XCTAssertTrue(error.errorUserInfo.isEmpty)
		}
	}
	
	func test_when_error_thrown_then_catchexceptionaserror_rethrows() throws {
		let urlError = URLError(.badURL)
		do {
			try catchExceptionAsError {
				throw urlError
			}
		} catch let error as URLError {
			XCTAssertEqual(error, urlError)
		}
	}
	
	func test_when_neither_error_nor_exception_thrown_then_catchexceptionaserror_returns_result() throws {
		let value = try catchExceptionAsError {
			return 42
		}
		XCTAssertEqual(value, 42)
	}
}
