//
//  User.swift
//  ranked
//
//  Created by Valentin Silvera on 19/10/22.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    var pollsParticipated: [String]
    var pollsCreated: [String]
}
