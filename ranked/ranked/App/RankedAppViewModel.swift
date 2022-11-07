//
//  RankedAppViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 7/11/22.
//

import Foundation

class RankedAppViewModel: ObservableObject {    
    @Published var poll: Poll?
    let service = PollService()
    
    init(url: URL) {
        fetchPoll(url)
    }
    
    func fetchPoll(_ url: URL) {
        guard url.scheme == Deeplink.scheme,
              url.lastPathComponent == Deeplink.pollPath
        else { return }
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        if let pollId = components?.queryItems?.first(where: { $0.name == Deeplink.pollIdQueryItem})?.value {
            service.fetchPoll(pollId) { poll in
                self.poll = poll
            }
        }
    }
}
