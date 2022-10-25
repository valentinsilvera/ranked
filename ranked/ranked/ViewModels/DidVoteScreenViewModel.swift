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
    @Published var didClosePoll = false
    @Published var isCreator = false
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
    
    func checkIfUserCreatedPoll() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if self.poll.uid == uid {
            print("DEBUG: \(self.poll.uid == uid)")
            self.isCreator = true
        }
    }
    
    func closePoll() {
        if isCreator {
            service.closePoll(poll: poll) { didClose in
                self.didClosePoll = didClose
            }
        }
    }
}
