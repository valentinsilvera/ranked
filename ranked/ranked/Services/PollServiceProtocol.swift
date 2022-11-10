//
//  PollServiceProtocol.swift
//  ranked
//
//  Created by Valentin Silvera on 9/11/22.
//

import Foundation

protocol PollServiceProtocol {
    func uploadPoll(title: String, creator: String, options: [String], completion: @escaping(Bool) -> Void)
    
    func fetchPolls(completion: @escaping([Poll]) -> Void)
    
    func uploadVote(poll: Poll, options: [String], completion: @escaping(Bool) -> Void)
    
    func checkIfUserVotedOnPoll(_ poll: Poll, completion: @escaping(Bool) -> Void)
    
    func checkForUserVoteOnPoll(_ poll: Poll, completion: @escaping([String]) -> Void)
    
    func fetchVotes(_ poll: Poll, completion: @escaping([Vote]) -> Void)
    
    func closePoll(poll: Poll, completion: @escaping(Bool) -> Void)
}
