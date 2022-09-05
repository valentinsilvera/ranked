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
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(poll: onboardingPoll).environmentObject(AuthViewModel())
        }
    }
}
