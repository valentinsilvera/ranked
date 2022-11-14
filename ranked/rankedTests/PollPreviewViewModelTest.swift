//
//  PollPreviewViewModelTest.swift
//  rankedTests
//
//  Created by Valentin Silvera on 10/11/22.
//

import XCTest
@testable import ranked

final class PollPreviewViewModelTest: XCTestCase {
    
    var viewModel: PollPreviewViewModel!
    var mockedService: MockPollService!
    
    var mockedPoll : Poll = Poll(uid: "uid1",
                                 title: "Mocked Poll 1",
                                 creator: "Creator 1",
                                 options: ["Option 1", "Option 2"],
                                 timestamp: nil,
                                 isClosed: false)
    
    var mockedVote = [Vote(ballot: ["vote1"]), Vote(ballot: ["vote 2"])]
    
    override func setUp() {
        mockedService = MockPollService()
        viewModel = .init(poll: mockedPoll, service: mockedService)
    }
    
    func testIfCorrectUserVotedOnPoll() {
        viewModel.checkIfUserVotedOnPoll()
        XCTAssertTrue(viewModel.poll.votedOn != nil)
    }
    
    func testFetchVotes() {
        viewModel.fetchVotes()
        XCTAssertEqual(viewModel.votes, mockedVote)
    }
}
