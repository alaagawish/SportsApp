//
//  LeagueDetailsTests.swift
//  SportsAppTests
//
//  Created by Alaa on 24/05/2023.
//

import XCTest
@testable import SportsApp
final class LeagueDetailsTests: XCTestCase {
    var leagueDetails: LeagueDetailsViewModel?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        leagueDetails = LeagueDetailsViewModelMock(sport: "football", leagueId: 4, localSource: LocalSourceTests(),network: NetworkMock(isSuccess: true))
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        leagueDetails = nil
    }
    
    func testGetLatestEvents(){
        leagueDetails?.getLatestEvents()
        
        XCTAssertNotNil(leagueDetails?.latestEvents)
        
    }
    func testGetUpcomingEvents(){
        leagueDetails?.getUpComingEvents()
        
        XCTAssertNotNil(leagueDetails?.upComingEvents)
        
    }
}
