//
//  User.swift
//  ranked
//
//  Created by Valentin Silvera on 19/10/22.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    /// The Firestore document ID is needed to update / delete the document
    @DocumentID var id: String?
    /// A subcollection with the IDs of the polls that the user voted on
    var pollsParticipated: [String]
    /// A subcollection with the IDs of the polls that the user created
    var pollsCreated: [String]
}
