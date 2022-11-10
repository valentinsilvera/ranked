//
//  Poll.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Firebase
import FirebaseFirestoreSwift

struct Poll: Identifiable, Codable, Equatable {
    @DocumentID var id: String? // The Firestore document ID is needed to update / delete the document
    let uid: String // the user id of the poll creator
    let title: String
    let creator: String
    let options: [String]
    let timestamp: Timestamp?
    let deadline: Date?
    var isClosed: Bool
    let result: String?

    var votedOn: Bool?
}

let onboardingPoll = Poll(uid: "uid", title: "Onboarding Poll", creator: "The Creator", options: ["Option 1", "Option 2"], timestamp: Timestamp(), deadline: nil, isClosed: false, result: nil)
