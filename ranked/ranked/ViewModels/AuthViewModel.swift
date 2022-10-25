//
//  AuthViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 1/9/22.
//

import FirebaseAuth
import SwiftUI

final class AuthViewModel: ObservableObject {
    
    @Published var user: FirebaseAuth.User?
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.user = user
        }
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            print("DEBUG: User signed in with uid \(authResult?.user.uid ?? "No user found")")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("DEBUG: Error signing out: \(signOutError)")
        }
    }
}
