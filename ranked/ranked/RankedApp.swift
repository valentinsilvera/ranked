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
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreen(poll: onboardingPoll).environmentObject(viewModel)
        }
    }
}
