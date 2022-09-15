//
//  ContentView.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI
import FirebaseAuth

struct HomeScreen: View {
    @EnvironmentObject private var authModel: AuthViewModel
    
    var poll: Poll
    
    var body: some View {
        NavigationView {
            Group {
                NavigationLink(destination: VoteScreen(poll: poll)) {
                    HomeCardView(poll: poll)
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(poll: onboardingPoll)
    }
}
