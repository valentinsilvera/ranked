//
//  DidVoteScreenViewModelTest.swift
//  rankedTests
//
//  Created by Valentin Silvera on 10/11/22.
//

import XCTest
@testable import ranked

final class DidVoteScreenViewModelTest: XCTestCase {
    
    var viewModel: DidVoteScreenViewModel!
    var mockedService: MockPollService!
    
    var mockedPoll : Poll = Poll(uid: "uid1",
                                 title: "Mocked Poll 1",
                                 creator: "Creator 1",
                                 options: ["Option 1", "Option 2"],
                                 timestamp: nil,
                                 deadline: nil,
                                 isClosed: false,
                                 result: nil)
    
    var mockedVote = ["vote1", "vote2"]
    
    override func setUp() {
        mockedService = MockPollService()
        viewModel = .init(poll: mockedPoll, service: mockedService)
    }
    
    func testCheckForUserVoteOnPoll() {
        viewModel.checkForUserVoteOnPoll()
        XCTAssertEqual(viewModel.ranked, mockedVote)
    }
    
    func testClosePollWithCorrectUser() {
        viewModel.isCreator = true
        viewModel.closePoll()
        XCTAssertTrue(viewModel.didClosePoll)
    }
    
    func testClosePollWithIncorrectUser() {
        viewModel.isCreator = false
        viewModel.closePoll()
        XCTAssertFalse(viewModel.didClosePoll)
    }
}
