//
//  NetworkTest.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import XCTest
@testable import SportsApp
final class NetworkTest: XCTestCase {
    
    var network: NetworkProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = Network()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
        
    }
    
    func testGetDataLeagues(){
        let myExpectation = expectation(description: "waiting network")
        
        network.getData(path: "Leagues", sport: "basketball") { (myResponse: MyResponse!) in
            guard let myResponse = myResponse else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
       
            XCTAssertEqual(myResponse.success, 1)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    
    func testGetData(){
        let myExpectation = expectation(description: "waiting network")
        network.getData(path: "Leagues", sport: "football") { (myResponse: MyResponse!) in
            guard let myResponse = myResponse else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertNotNil(myResponse)
            myExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 10)
    }
    
}
