//
//  DidVoteScreenViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 20/10/22.
//

import Firebase

class DidVoteScreenViewModel: ObservableObject {
    @Published var poll: Poll
    @Published var ranked = [String]()
    @Published var unranked = [String]()
    let service = PollService()
    
    init(poll: Poll) {
        self.poll = poll
    }
    
    func checkForUserVoteOnPoll() {
        service.checkForUserVoteOnPoll(self.poll) { vote in
            self.ranked = vote
            self.unranked = self.poll.options.filter { !self.ranked.contains($0) }
        }
    }
}
