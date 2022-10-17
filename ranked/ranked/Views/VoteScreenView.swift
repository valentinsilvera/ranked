//
//  VoteScreen.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct VoteScreenView: View {
    var poll: Poll
    @ObservedObject var viewModel: VoteScreenViewModel
    @State private var noPreferenceList = [String]()
    @State private var preferenceList = [String]()
    
    init(poll: Poll) {
        self.poll = poll
        self.viewModel = VoteScreenViewModel(poll: poll, noPreferenceList: poll.options)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("by \(poll.uid)")
                    Spacer()
                }
                
//                List {
//                    Text("Preference List")
//                        .font(.subheadline)
//                    ForEach(preferenceList, id: \.self) { user in
//                        Text(user)
//                            .onDrag { NSItemProvider(object: user as NSString) }
//                    }
//                    .onMove(perform: viewModel.movePreferenceList())
//                    .onInsert(of: ["public.text"], perform: viewModel.dropPreferenceList())
//                }
                
            }
            .navigationTitle(poll.title)
        }
        // this sets instance properties that need other instance properties initialized before
        .onAppear {
            noPreferenceList = poll.options
        }
    }
}

struct VoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        VoteScreenView(poll: onboardingPoll)
    }
}
