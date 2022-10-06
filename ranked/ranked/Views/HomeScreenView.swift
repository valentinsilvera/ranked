//
//  ContentView.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI
import FirebaseAuth

struct HomeScreenView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    
    
    var body: some View {
        NavigationView {
            Group {
//                NavigationLink(destination: VoteScreen(poll: poll)) {
//                    HomePollView(poll: poll)
//                }
            }
            .navigationTitle("Home")
        }
        .onAppear() {
            authVM.signInAnonymously()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
