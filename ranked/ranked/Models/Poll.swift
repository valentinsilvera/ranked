//
//  Vote.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Foundation

struct Poll: Codable, Identifiable{
    var id: String = UUID().uuidString
    let title: String
    let options: [String]
    let votes: [String]
    let creator: String
    var dateCreated = Date()
    let deadline: Date?
    var isClosed: Bool = false
    var votedOn: Bool = false
    let result: String?
}

let onboardingPoll = Poll(title: "How to use Ranked?", options: [ "Option 1", "Option 2", "Option 3", "Option 4"], votes: [""], creator: "The creator", deadline: nil, votedOn: true, result: nil)
