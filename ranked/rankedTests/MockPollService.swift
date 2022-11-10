//
//  MockPollService.swift
//  rankedTests
//
//  Created by Valentin Silvera on 8/11/22.
//

@testable import ranked

struct MockPollService: PollServiceProtocol {
    var mockedPoll1 : Poll = Poll(uid: "uid1",
                                 title: "Mocked Poll 1",
                                 creator: "Creator 1",
                                 options: ["Option 1", "Option 2"],
                                 timestamp: nil,
                                 deadline: nil,
                                 isClosed: false,
                                 result: nil)
    
    var mockedPoll2 : Poll = Poll(uid: "uid2",
                                  title: "Mocked Poll 2",
                                  creator: "Creator 2",
                                  options: ["Option 1", "Option 2"],
                                  timestamp: nil,
                                  deadline: nil,
                                  isClosed: false,
                                  result: nil)
    
    func uploadPoll(title: String, creator: String, options: [String], completion: @escaping(Bool) -> Void) {
        completion(true)
    }
    
    func fetchPolls(completion: @escaping([Poll]) -> Void) {
        completion([mockedPoll1, mockedPoll2])
    }
    
    func uploadVote(poll: Poll, options: [String], completion: @escaping(Bool) -> Void) {
        completion(true)
    }
    
    func checkIfUserVotedOnPoll(_ poll: Poll, completion: @escaping(Bool) -> Void) {
        completion(true)
    }
    
    func checkForUserVoteOnPoll(_ poll: Poll, completion: @escaping([String]) -> Void) {
        completion(["vote1", "vote2"])
    }
    
    func fetchVotes(_ poll: Poll, completion: @escaping([Vote]) -> Void) {
        completion([Vote(ballot: ["vote1"]), Vote(ballot: ["vote 2"])])
    }
    
    func closePoll(poll: Poll, completion: @escaping(Bool) -> Void) {
        completion(true)
    }
}
