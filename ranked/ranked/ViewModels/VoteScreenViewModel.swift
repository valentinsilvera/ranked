//
//  VoteScreenViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 13/10/22.
//

import Foundation

class VoteScreenViewModel: ObservableObject {
    @Published var didUploadVote = false
    let service = PollService()
    
    func uploadVote(withOptions options: [String]) {
        service.uploadVote(options: options) { success in
            if success {
                self.didUploadVote = true
            } else {
                print("DEBUG: Failed to upload vote")
            }
        }
    }
}
