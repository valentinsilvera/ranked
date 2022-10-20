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
    let service = PollService()
    
    init(poll: Poll) {
        self.poll = poll
    }
    
    func uploadVote(withOptions options: [String]) {
        service.uploadVote(poll: poll, options: options) { success in
            if success {
                self.didUploadVote = true
                print("DEBUG: \(options)")
            } else {
                print("DEBUG: Failed to upload vote")
                print("DEBUG: \(options)")
            }
        }
    }
}
