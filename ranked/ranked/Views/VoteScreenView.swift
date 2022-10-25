//
//  VoteScreen.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct VoteScreenView: View {
    @ObservedObject var viewModel: VoteScreenViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var noPreferenceList = [String]()
    @State private var preferenceList = [String]()
    @State private var showConfirmation = false
    
    init(poll: Poll) {
        self.viewModel = VoteScreenViewModel(poll: poll)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text(viewModel.poll.title)
                    .font(.largeTitle)
                    .padding(.horizontal)
                    .bold()
                
                Text("by \(viewModel.poll.creator)")
                    .padding(.horizontal)
                    .padding(.top, 2)
                
                Spacer()
                
                HStack(spacing: 0) {
                    DroppableList("Preference", options: $preferenceList)  { dropped, index in
                        preferenceList.insert(dropped, at: index)
                        noPreferenceList.removeAll { $0 == dropped }
                    }
                    .padding(.trailing, -8)
                    
                    DroppableList("No Preference", options: $noPreferenceList) { dropped, index in
                        noPreferenceList.insert(dropped, at: index)
                        preferenceList.removeAll { $0 == dropped }
                    }
                    .padding(.leading, -8)
                }
                
                Spacer()
                
                Button {
                    showConfirmation = true
                } label: {
                    Text("Submit Vote")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding()
                }
                .confirmationDialog("Submit this vote? You won't be able to change it afterwards!", isPresented: $showConfirmation, titleVisibility: .visible) {
                    Button {
                        viewModel.uploadVote(withOptions: preferenceList)
                    } label: {
                        Text("Yes")
                    }
                    .onReceive(viewModel.$didUploadVote) { success in
                        if success {
                            dismiss()
                        }
                    }
                }
            }
        }
        // this sets instance properties that need other instance properties initialized before
        .onAppear {
            noPreferenceList = viewModel.poll.options
        }
        .padding(.top, -40)
    }
}

struct VoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        VoteScreenView(poll: onboardingPoll)
    }
}
