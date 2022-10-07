//
//  Poll.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Firebase
import FirebaseFirestoreSwift

struct Poll: Identifiable, Codable {
    /// The Firestore document ID is needed to update / delete the document
    @DocumentID var id: String?
    let uid: String
    let title: String
    let options: [String]
    let votes: [String]?
    let timestamp: Timestamp
    let deadline: Date?
    var isClosed: Bool
    let result: String?

    var votedOn: Bool?
}

let onboardingPoll = Poll(uid: "uid", title: "Onboarding Poll", options: ["Option 1", "Option 2"], votes: nil, timestamp: Timestamp(), deadline: nil, isClosed: false, result: nil)
