//
//  NewPollViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 7/10/22.
//

import Foundation

class NewPollViewModel: ObservableObject {
    @Published var didUploadPoll = false
    let service = PollService()
    
    func uploadPoll(withTitle title: String, withOptions options: [String]) {
        service.uploadPoll(title: title, options: options) { success in
            if success {
                self.didUploadPoll = true
            } else {
                print("DEBUG: Failed to upload poll")
            }
        }
    }
}
