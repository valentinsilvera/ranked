//
//  ContentView.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            NavigationLink(destination: VoteScreen()) {
                HomeCardView()
            }   
        }
        .padding(12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
