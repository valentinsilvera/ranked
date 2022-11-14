//
//  HomeCardView.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct PollPreviewView: View {
    @ObservedObject var viewModel: PollPreviewViewModel
    
    init(poll: Poll) {
        self.viewModel = PollPreviewViewModel(poll: poll)
    }
    
    var body: some View {
        NavigationLink(destination: getDestination(votedOn: viewModel.poll.votedOn ?? false, isClosed: viewModel.poll.isClosed)) {
            ZStack {
                /// Background
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(LinearGradient(colors: [.pink, .purple],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .frame(maxWidth: UIScreen.main.bounds.size.width, minHeight: 100, maxHeight: 120)
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "star.bubble.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                            
                            Spacer()
                            
                            /// Checks wether the user voted on the poll to display in the the UI with a checkmark
                            if viewModel.poll.votedOn ?? false {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        
                        HStack{
                            VStack(alignment: .leading) {
                                Text(viewModel.poll.title)
                                    .font(.title2)
                                
                                HStack{
                                    Text("by \(viewModel.poll.creator)")
                                        .font(.callout)
                                    
                                    Spacer()
                                    
                                    /// Displays number of votes on the ui
                                    HStack {
                                        Image(systemName: "person.3.fill")
                                        Text("\(viewModel.votes.count)")
                                    }
                                    .font(.callout)
                                }
                            }
                        }
                    }
                }
                .padding(12)
                .foregroundColor(.white)
            }
            .padding(.top, 8)
            .padding([.leading, .trailing])
        }
    }
    
    /// Calculates which view to return depending on wether the user has voted, and if the poll is still open
    func getDestination(votedOn: Bool, isClosed: Bool) -> AnyView {
        if isClosed {
            return AnyView(ResultsView(poll: viewModel.poll, votes: viewModel.votes))
        } else if votedOn {
            return AnyView(DidVoteScreenView(poll: viewModel.poll))
        } else {
            return AnyView(VoteScreenView(poll: viewModel.poll))
        }
    }
}

struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        PollPreviewView(poll: onboardingPoll)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Default preview")
    }
}
