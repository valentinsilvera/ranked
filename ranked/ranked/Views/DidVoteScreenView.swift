//
//  DidVoteScreenView.swift
//  ranked
//
//  Created by Valentin Silvera on 20/10/22.
//

import SwiftUI

struct DidVoteScreenView: View {
    @State private var showConfirmation = false
    @ObservedObject var viewModel: DidVoteScreenViewModel
    @Environment(\.dismiss) private var dismiss // used for stacked navigation
    
    init(poll: Poll) {
        self.viewModel = DidVoteScreenViewModel(poll: poll)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .purple],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text(viewModel.poll.title)
                    .font(.largeTitle)
                    .padding(.horizontal)
                    .bold()
                
                Text("created by \(viewModel.poll.creator)")
                    .font(.headline)
                    .padding(.horizontal)
                
                List{
                    Section(header: Text("Ranked options:")) {
                        /// Checks if there are ranked options and displays a user-friendly message in case they haven't ranked any; else, displays the ranked options
                        if viewModel.ranked.count == 0 {
                            Text("You didn't rank any of the options")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(Array(zip(viewModel.ranked.indices, viewModel.ranked)),
                                    id: \.0) { index, vote in
                                Text("\(index+1) - \(vote)")
                            }
                        }
                    }
                    if viewModel.unranked.count > 0 {
                        Section(header: Text("Unranked options:")) {
                            ForEach(viewModel.unranked, id: \.self) { unranked in
                                Text("- \(unranked)")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                
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
                    dismiss()
                } label: {
                    Text("Go Back")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
            }
        }
        .padding(.top, -40)
        /// Waits for the view to load to fetch votes, to save on networking load
        .onAppear {
            viewModel.checkForUserVoteOnPoll()
            viewModel.checkIfUserCreatedPoll()
        }
    }
}

struct DidVoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        DidVoteScreenView(poll: onboardingPoll)
    }
}
