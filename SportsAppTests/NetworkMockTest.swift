//
//  NetworkMockTest.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import XCTest
@testable import SportsApp
final class NetworkMockTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testGetDataMock() {
        NetworkMock.getData(path: "", sport: "") { (myResult: MyResponse!) in
            XCTAssertEqual(myResult.success, 1)
            XCTAssertEqual(myResult.result.count, 3)
        }
    }

    func testGetDataMockFailCase() {
        NetworkMock.isSuccess  = false
        NetworkMock.getData(path: "", sport: "") { (myResult: MyResponse!) in
            XCTAssertNil(myResult)
        }
    }
}
