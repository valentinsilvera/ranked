//
//  VoteScreenViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 13/10/22.
//

import Firebase

class VoteScreenViewModel: ObservableObject {
    @Published var poll: Poll
    @Published var didUploadVote = false
    @Published var didClosePoll = false
    @Published var isCreator = false
    let service: PollServiceProtocol
    
    init(poll: Poll, service: PollServiceProtocol = PollService()) {
        self.service = service
        self.poll = poll
    }
    
    func uploadVote(withOptions options: [String]) {
        service.uploadVote(poll: poll, options: options) { success in
            if success {
                self.didUploadVote = true
            } else {
                print("DEBUG: Failed to upload vote")
            }
        }
    }
    
    func checkIfUserCreatedPoll() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if self.poll.uid == uid {
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
