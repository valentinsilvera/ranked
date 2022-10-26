//
//  HomeScreenViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 6/10/22.
//

import Foundation

class HomeScreenViewModel: ObservableObject {
    @Published var polls = [Poll]()
    let service = PollService()
    
    init() {
//        fetchPolls()
    }
    
    func fetchPolls() {
        service.fetchPolls { polls in
            self.polls = polls
        }
    }
}
