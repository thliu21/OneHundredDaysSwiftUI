//
//  CupcakeCornerTests.swift
//  CupcakeCornerTests
//
//  Created by Tianhao Liu on 12/4/22.
//

import XCTest
@testable import CupcakeCorner

final class CupcakeCornerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let json = """
        {"flavor":"Rainbow","quantity":5,"city":"Bbbbb","zip":"12355","streetAddress":"123 123","extraFrosting":true,"name":"ABC","addSprinkles":false}
        """
        let jsonData = json.data(using: .utf8)!
        let order: Order = try! JSONDecoder().decode(Order.self, from: jsonData)
        XCTAssertEqual(order.foodOrder.flavor, .rainbow)
        XCTAssertEqual(order.address.zip, "12355")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
