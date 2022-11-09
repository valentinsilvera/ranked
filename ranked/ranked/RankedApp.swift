//
//  rankedApp.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI
import Firebase

@main
struct rankedApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure() // signs the user in / listens to the auth state
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreenView().environmentObject(viewModel) // sets the user as an environment variable so it can be accessed from anywhere
        }
    }
}
