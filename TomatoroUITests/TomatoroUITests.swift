//
//  TomatoroUITests.swift
//  TomatoroUITests
//
//  Created by Łukasz Stachnik on 15/03/2023.
//

import XCTest

final class TomatoroUITests: XCTestCase {

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric(), XCTMemoryMetric(), XCTCPUMetric(), XCTStorageMetric()]) {
            XCUIApplication().launch()
        }
    }
}
