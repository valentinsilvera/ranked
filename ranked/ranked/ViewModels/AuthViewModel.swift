//
//  AuthViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 1/9/22.
//

import FirebaseAuth
import SwiftUI

/// The ViewModel that handles authentication
final class AuthViewModel: ObservableObject {
    
    /// A variable containing the user that is signed in, it can be observed by the entire app
    @Published var user: FirebaseAuth.User?
    
    /// Check for the authentication state of the current user / no user
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.user = user
        }
    }
    
    /// Sign in the user anonymously
    func signInAnonymously() {
        Auth.auth().signInAnonymously { authResult, error in
            print("DEBUG: User signed in with uid \(authResult?.user.uid ?? "No user found")")
        }
    }
    
    /// Sign the user out
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("DEBUG: Error signing out: \(signOutError)")
        }
    }
}
