//
//  LoadableTests.swift
//  UnitTests
//
//  Created by Alexey Naumov on 31.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import XCTest
@testable import CountriesSwiftUI

class LoadableTests: XCTestCase {

    func testEquality() {
        let possibleValues: [Loadable<Int>] = [
            .notRequested,
            .isLoading(last: nil),
            .isLoading(last: 9),
            .loaded(5),
            .loaded(6),
            .failed(NSError(domain: "", code: 0, userInfo: nil))
        ]
        possibleValues.enumerated().forEach { (index1, value1) in
            possibleValues.enumerated().forEach { (index2, value2) in
                if index1 == index2 {
                    XCTAssertEqual(value1, value2)
                } else {
                    XCTAssertNotEqual(value1, value2)
                }
            }
        }
    }

    func testHelpers() {
        let notRequested = Loadable<Int>.notRequested
        let loadingNil = Loadable<Int>.isLoading(last: nil)
        let loadingValue = Loadable<Int>.isLoading(last: 9)
        let loaded = Loadable<Int>.loaded(5)
        let failedErrValue = Loadable<Int>.failed(NSError(domain: "", code: 0, userInfo: nil))
        [notRequested, loadingNil].forEach {
            XCTAssertNil($0.value)
        }
        [loadingValue, loaded].forEach {
            XCTAssertNotNil($0.value)
        }
        [notRequested, loadingNil, loadingValue, loaded].forEach {
            XCTAssertNil($0.error)
        }
        XCTAssertNotNil(failedErrValue.error)
    }
}
