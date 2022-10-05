//
//  HomeCardViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 15/9/22.
//

import Foundation
import Combine

class HomeCardViewModel: ObservableObject, Identifiable {
    @Published var poll: Poll
    
    var id = ""
    @Published var votedOnStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(poll: Poll) {
        self.poll = poll
        
        $poll
            .map { poll in
                poll.votedOn ?? false ? "checkmark.circle.fill" : ""
            }
            .assign(to: \.votedOnStateIconName, on: self)
            .store(in: &cancellables)
        
        $poll
            .map { poll in
                poll.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
