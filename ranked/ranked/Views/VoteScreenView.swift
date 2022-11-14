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
    /// The two following lists store the options as the user ranks them
    @State private var noPreferenceList = [String]()
    @State private var preferenceList = [String]()
    @State private var showConfirmation = false
    
    init(poll: Poll) {
        self.viewModel = VoteScreenViewModel(poll: poll)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea() // background
            
            VStack(alignment: .leading) {
                Text(viewModel.poll.title)
                    .font(.largeTitle)
                    .padding(.horizontal)
                    .bold()
                
                Text("created by \(viewModel.poll.creator)")
                    .font(.headline)
                    .padding(.horizontal)
                
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
                
                /// Only the creator of the poll gets presented this button, due to the destructive nature, it presents a confirmation beforehand
                if viewModel.isCreator {
                    Button {
                        showConfirmation = true
                    } label: {
                        Text("Close Poll")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(width: 360, height: 50)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .padding([.horizontal, .top])
                    }
                    .confirmationDialog("Close this poll? People won't be able to vote anymore, and results will be calculated", isPresented: $showConfirmation, titleVisibility: .visible) {
                        Button {
                            viewModel.closePoll()
                        } label: {
                            Text("Yes")
                        }
                        .onReceive(viewModel.$didClosePoll) { success in
                            if success {
                                dismiss()
                            }
                        }
                    }
                }
                
                Button {
                    showConfirmation = true
                } label: {
                    Text("Submit Vote")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .padding(.vertical, 8)
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
        /// This sets instance properties that need other instance properties initialized before
        .onAppear {
            noPreferenceList = viewModel.poll.options
            viewModel.checkIfUserCreatedPoll()
        }
        .padding(.top, -40)
    }
}

struct VoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        VoteScreenView(poll: onboardingPoll)
    }
}
