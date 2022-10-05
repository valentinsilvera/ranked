//
//  UserService.swift
//  ranked
//
//  Created by Valentin Silvera on 4/10/22.
//

import Firebase

//struct UserService {
//    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
//        Firestore.firestore().collection("users")
//            .document(uid)
//            .getDocument { snapshot, _ in
//                guard let _ = snapshot else { return }
//                
//                guard let user = try? snapshot?.data(as: User.self) else { return }
//                
//                completion(user)
//            }
//    }
//}
