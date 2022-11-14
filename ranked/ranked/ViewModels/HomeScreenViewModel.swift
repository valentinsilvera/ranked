//
//  HomeScreenViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 6/10/22.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    @Published var polls = [Poll]()
    let service: PollServiceProtocol
    
    init(service: PollServiceProtocol = PollService()) {
        self.service = service
        fetchPolls()
    }
    
    /// Fetches the polls using the service and assigns them to the published variable
    func fetchPolls() {
        service.fetchPolls { polls in
            self.polls = polls
        }
    }
}
