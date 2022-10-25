//
//  ResultsViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 25/10/22.
//

import Foundation

class ResultsViewModel: ObservableObject {
    @Published var poll: Poll
    @Published var votes: [Vote]
    private let service = PollService()
    
    init(poll: Poll, votes: [Vote]) {
        self.poll = poll
        self.votes = votes
    }
}
