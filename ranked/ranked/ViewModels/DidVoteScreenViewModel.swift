//
//  DidVoteScreenViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 20/10/22.
//

import Firebase

class DidVoteScreenViewModel: ObservableObject {
    @Published var poll: Poll
    @Published var ranked = [Vote]()
    @Published var unranked = [String]()
    let service = PollService()
    
    init(poll: Poll) {
        self.poll = poll
//        checkForUserVoteOnPoll()
    }
    
    func removeOptions() {
        var options = poll.options
//        checkForUserVoteOnPoll()
    }
    
    func checkForUserVoteOnPoll() {
        service.checkForUserVoteOnPoll(self.poll) { vote in
            print("DEBUG: \(vote)")
            print("DEBUG: \(self.poll)")
        }
    }
}
