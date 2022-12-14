//
//  NewPollViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 7/10/22.
//

import Foundation

class NewPollViewModel: ObservableObject {
    @Published var didUploadPoll = false
    let service: PollServiceProtocol
    
    init(service: PollServiceProtocol = PollService()) {
        self.service = service
    }
    
    func uploadPoll(withTitle title: String, by creator: String, withOptions options: [String]) {
        service.uploadPoll(title: title, creator: creator, options: options) { success in
            if success {
                self.didUploadPoll = true
            } else {
                self.didUploadPoll = false
            }
        }
    }
}
