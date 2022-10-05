//
//  HomeCardListViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 15/9/22.
//

import Foundation
import Combine

class HomeCardListViewModel: ObservableObject, Identifiable {
    @Published var pollRepository = PollRepository()
    @Published var homeCardViewModels = [HomeCardListViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        pollRepository.$polls
            .map { polls in
                polls.map { poll in
                    HomeCardViewModel(poll: poll)
                }
            }
//            .assign(to: \.homeCardViewModels, on: self)
    }
}

