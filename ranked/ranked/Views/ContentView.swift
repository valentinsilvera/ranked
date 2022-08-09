//
//  ContentView.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct ContentView: View {
    var ballot: Ballot
    
    var body: some View {
        NavigationView {
            Group {
                NavigationLink(destination: VoteScreen(ballot: ballot)) {
                    HomeCardView(ballot: ballot)
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(ballot: onboardingBallot)
    }
}
