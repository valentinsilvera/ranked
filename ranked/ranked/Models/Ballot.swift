//
//  Vote.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Foundation

struct Ballot{
    let id: Int
    let title: String
    let options: [Option]
    let votes: [String]
    let creator: String
    var dateCreated = Date()
    let deadline: Date?
    var isClosed: Bool = false
    var votedOn: Bool = false
    let result: String?
}

let onboardingBallot = Ballot(id: 1, title: "How to use Ranked?", options: [Option(id: 1, name: "Option 1", isRanked: false), Option(id: 2, name: "Option 2", isRanked: false), Option(id: 3, name: "Option 3", isRanked: true), Option(id: 4, name: "Option 4", isRanked: false)], votes: [""], creator: "The creator", deadline: nil, votedOn: true, result: nil)
