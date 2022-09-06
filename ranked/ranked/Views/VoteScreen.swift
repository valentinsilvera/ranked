//
//  VoteScreen.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct VoteScreen: View {
    @EnvironmentObject private var optionList: OptionList
    var poll: Poll
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("by \(poll.creator)")
                    Spacer()
                    OptionListView().environmentObject(OptionList())
                }
                
            }
            .navigationTitle(poll.title)
        }
    }
}

struct VoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        VoteScreen(poll: onboardingPoll)
    }
}
