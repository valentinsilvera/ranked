//
//  PollPreviewViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 20/10/22.
//

import Foundation

class PollPreviewViewModel: ObservableObject {
    @Published var poll: Poll
    private let service = PollService()
    
    init(poll: Poll) {
        self.poll = poll
        checkIfUserVotedOnPoll()
    }
    
    func checkIfUserVotedOnPoll() {
        service.checkIfUserVotedOnPoll(poll) { votedOn in
            if votedOn {
                self.poll.votedOn = true
            }
        }
    }
}
