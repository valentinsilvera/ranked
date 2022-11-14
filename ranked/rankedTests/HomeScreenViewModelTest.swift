//
//  HomeScreenViewModelTest.swift
//  rankedTests
//
//  Created by Valentin Silvera on 8/11/22.
//

import XCTest
@testable import ranked

final class HomeScreenViewModelTest: XCTestCase {
    
    var viewModel: HomeScreenViewModel!
    var mockedService: MockPollService!
    
    var mockedPoll1 : Poll = Poll(uid: "uid1",
                                  title: "Mocked Poll 1",
                                  creator: "Creator 1",
                                  options: ["Option 1", "Option 2"],
                                  timestamp: nil,
                                  isClosed: false)
    
    var mockedPoll2 : Poll = Poll(uid: "uid2",
                                  title: "Mocked Poll 2",
                                  creator: "Creator 2",
                                  options: ["Option 1", "Option 2"],
                                  timestamp: nil,
                                  isClosed: false)

    override func setUp() {
        mockedService = MockPollService()
        viewModel = .init(service: mockedService)
    }
    
    func testFetchPolls() {
        viewModel.fetchPolls()
        XCTAssertTrue(viewModel.polls == [mockedPoll1, mockedPoll2])
    }
}
