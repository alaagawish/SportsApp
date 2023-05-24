//
//  LeagueDetailsViewModelTest.swift
//  SportsAppTests
//
//  Created by Alaa on 23/05/2023.
//

import XCTest
@testable import SportsApp
final class LeagueDetailsViewModelTests: XCTestCase {
    
    
    var leagueDetails: LeagueDetailsViewModel?
    var network: NetworkProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = RemoteSourceMock(isSuccess: true)
        leagueDetails = LeagueDetailsViewModel(sport: "football", leagueId: 4, localSource: LocalSourceMock(),network: network)
        leagueDetails?.sport = "football"
        leagueDetails?.leagueId = 4
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        leagueDetails = nil
        network = nil
    }
    
    func testGetLatestEvents(){
        leagueDetails?.getLatestEvents()
        
        XCTAssertNotNil(leagueDetails?.latestEvents)
        XCTAssertEqual(leagueDetails?.latestEvents.count, 3)
        
    }
    func testGetLatestEventsCount(){
        leagueDetails?.getLatestEvents()
        XCTAssertEqual(leagueDetails?.latestEvents.count, 3)
        
    }
    
    func testGetUpcomingEvents(){
        leagueDetails?.getUpComingEvents()
        XCTAssertNotNil(leagueDetails?.upComingEvents)
        
    }
    func testGetUpcomingEventsCount(){
        leagueDetails?.getUpComingEvents()
        XCTAssertEqual(leagueDetails?.upComingEvents.count, 3)
        
    }
    func testDeleteLeague(){
        let countOfFav = leagueDetails?.localSource.getDataFromLocal().count
        leagueDetails?.deleteLeague(name: "sport2", key: 1)
        let newCount = leagueDetails?.localSource.getDataFromLocal().count
        
        XCTAssertEqual(newCount, countOfFav! - 1)
        
    }
    func testDeleteLeague2(){
        
        leagueDetails?.deleteLeague(name: "sport2", key: 1)
        
        var league: LeagueLocal?
        league = leagueDetails?.getSelectedLeague(name: "sport2", key: 1)
        XCTAssertNil(league)
    }
    
    func testGetSelectedLeague(){
        let l = LeagueLocal(sport: "tennis", youtube: "", name: "sport3", logo: "sport3", key: 2)
        let league = leagueDetails?.getSelectedLeague(name: l.name, key: l.key)
        XCTAssert(league?.name == "sport3")
        XCTAssert(league?.key == 2)
        
        
    }
    
    func testGetSelectedLeague2(){
        let l = LeagueLocal(sport: "tennis", youtube: "", name: "sport3", logo: "sport3", key: 2)
        let league = leagueDetails?.getSelectedLeague(name: l.name, key: l.key)
        XCTAssertNotNil(league)
        XCTAssertEqual(league?.sport == "tennis", true)
        
    }
    func testAddToFav(){
        let countOfFav = leagueDetails?.localSource.getDataFromLocal().count
        leagueDetails?.addToFav(l: LeagueLocal(sport: "football", youtube: "", name: "footballSport", logo: "", key: 10))
        let newCount = leagueDetails?.localSource.getDataFromLocal().count
        
        XCTAssertEqual(newCount, countOfFav!+1)
        
    }
    func testAddToFav2(){
        
        leagueDetails?.addToFav(l: LeagueLocal(sport: "football", youtube: "", name: "footballSport", logo: "", key: 10))
        let league = leagueDetails?.getSelectedLeague(name: "footballSport", key: 10)
        
        XCTAssertTrue(league?.sport == "football")
        
    }
    
    
}
