//
//  VoteScreen.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct VoteScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            Text("Some text")
        }
    }
}

struct VoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        VoteScreen()
    }
}
