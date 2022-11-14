//
//  Vote.swift
//  ranked
//
//  Created by Valentin Silvera on 25/10/22.
//

import Firebase
import FirebaseFirestoreSwift

struct Vote: Identifiable, Codable, Equatable {
    /// The Firestore document ID is needed to update / delete the document
    @DocumentID var id: String?
    /// The ballot cotaining the options ordered by preference
    let ballot: [String]
}
