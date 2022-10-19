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
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let userVotesRef = Firestore.firestore().collection("users").document(uid).collection("voted-polls")
        
        service.uploadVote(poll: Poll, options: options) { success in
            if success {
                self.didUploadVote = true
            } else {
                print("DEBUG: Failed to upload vote")
            }
        }
    }
}
