//
//  NetworkTest.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import XCTest
@testable import SportsApp
final class NetworkTest: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    func testGetDataLeagues(){
        let myExpectation = expectation(description: "waiting network")
        
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let formattedDate = dateFormatter.string(from: currentDate)
        
        print("Current date: \(formattedDate)")
        var dateComponents = DateComponents()
        dateComponents.year = 1
        
        let calendar = Calendar.current
        let newDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        let nextDateFormatter = DateFormatter()
        nextDateFormatter.dateFormat = "yyyy-MM-dd"
        nextDateFormatter.locale = Locale(identifier: "en_US")
        var newFormattedDate = "2025-05-27"
        if let newDate = newDate{
            newFormattedDate = nextDateFormatter.string(from: newDate)
        }
        Network.getData(path: "Fixtures&leagueId=\( 4)&from=\(formattedDate)&to=\(newFormattedDate)", sport:   "football") {
            (myResponse: EventResponse!) in
            guard let myResponse = myResponse else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertNotNil(myResponse)
            XCTAssertEqual(myResponse.success, 1)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
    }
    
    
    func testGetData(){
        let myExpectation = expectation(description: "waiting network")
        Network.getData(path: "Leagues", sport: "basketball") { (myResponse: MyResponse!) in
            guard let myResponse = myResponse else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertNotNil(myResponse)
            XCTAssertEqual(myResponse.success, 1)
            myExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 10)
    }
    
}
