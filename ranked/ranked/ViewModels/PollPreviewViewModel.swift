//
//  PollPreviewViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 20/10/22.
//

import Foundation

class PollPreviewViewModel: ObservableObject {
    @Published var poll: Poll
    @Published var votes = [Vote]()
    private let service = PollService()
    
    init(poll: Poll) {
        self.poll = poll
        checkIfUserVotedOnPoll()
        fetchVotes()
    }
    
    func checkIfUserVotedOnPoll() {
        service.checkIfUserVotedOnPoll(poll) { votedOn in
            if votedOn {
                self.poll.votedOn = true
            }
        }
    }
    
    func fetchVotes() {
        service.fetchVotes(poll) { votes in
            self.votes = votes
        }
    }
}
