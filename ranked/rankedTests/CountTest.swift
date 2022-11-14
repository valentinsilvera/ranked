//
//  CountTest.swift
//  rankedTests
//
//  Created by Valentin Silvera on 12/11/22.
//

import XCTest
@testable import ranked

final class CountTest: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testCount() {
        // given
        let sampleVotes = [
            Vote(ballot: ["pizza", "burger", "sushi", "ramen"]),
            Vote(ballot: ["ramen", "sushi",]),
            Vote(ballot: ["ramen", "pizza",]),
            Vote(ballot: ["burger", "pizza", "ramen"]),
            Vote(ballot: ["sushi", "burger"]),
            Vote(ballot: ["burger", "sushi"]),
            Vote(ballot: ["pizza", "burger", "sushi"]),
            Vote(ballot: ["pizza", "burger", "sushi"])
        ]
        
        let expectedResult = "pizza"
        
        // when
        let sampleResults = Count(votes: sampleVotes)
        
        //then
        XCTAssertEqual(sampleResults.winner.first?.key, expectedResult)
    }
}
