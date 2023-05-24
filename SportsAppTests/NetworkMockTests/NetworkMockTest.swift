//
//  NetworkMockTest.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import XCTest
@testable import SportsApp
final class NetworkMockTest: XCTestCase {
    var networkMock:NetworkProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkMock = NetworkMock(isSuccess: true)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkMock = nil
    }
    
    
    func testGetDataMock() {
        networkMock.getData(path: "", sport: "") { (myResult: MyResponse!) in
            XCTAssertEqual(myResult.success, 1)
            XCTAssertEqual(myResult.result.count, 3)
        }
    }
    
    func testGetDataMockFailCase() {
        networkMock = NetworkMock(isSuccess: false)
        networkMock.getData(path: "", sport: "") { (myResult: MyResponse!) in
            XCTAssertNil(myResult)
        }
    }
    func testGetDataMockFailCase2() {
        networkMock = NetworkMock(isSuccess: false)
        networkMock.getData(path: "", sport: "") { (myResult: MyResponse!) in
            XCTAssertNil(myResult)
        }
    }
}
