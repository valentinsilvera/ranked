//
//  VoteScreen.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct VoteScreenView: View {
    var poll: Poll
    @ObservedObject var viewModel = VoteScreenViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var noPreferenceList = [String]()
    @State private var preferenceList = [String]()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("by \(poll.uid)")
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    DroppableList("Preference", options: $preferenceList)  { dropped, index in
                        preferenceList.insert(dropped, at: index)
                        noPreferenceList.removeAll { $0 == dropped }
                    }
                    
                    DroppableList("No Preference", options: $noPreferenceList) { dropped, index in
                        noPreferenceList.insert(dropped, at: index)
                        preferenceList.removeAll { $0 == dropped }
                    }
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Submit Vote")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .frame(width: 360, height: 50)
                            .background(Color.secondary)
                            .clipShape(Capsule())
                            .padding()
                    }
                    .onReceive(viewModel.$didUploadVote) { success in
                        if success {
                            dismiss()
                        }
                    }
                }
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
