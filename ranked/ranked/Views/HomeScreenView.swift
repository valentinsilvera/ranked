//
//  ContentView.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI
import FirebaseAuth

struct HomeScreenView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @ObservedObject var viewModel = HomeScreenViewModel()
    @State var showNewPollView = false
    
    var body: some View {
        
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    ScrollView {
                        Group {
                            NavigationLink(destination: VoteScreenView(poll: onboardingPoll)) {
                                PollPreviewView(poll: onboardingPoll)
                            }
                            ForEach(viewModel.polls) { poll in
                                NavigationLink(destination: VoteScreenView(poll: poll)) {
                                    PollPreviewView(poll: poll)
                                }
                            }
                        }
                        .navigationTitle("Home")
                        
                        Spacer()
                    }
                    .refreshable {
                        viewModel.fetchPolls()
                    }
                    
                    
                    Button {
                        showNewPollView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 55, height: 55)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    .fullScreenCover(isPresented: $showNewPollView) {
                        NewPollView()
                    }
                }
        }
        .onAppear() {
            authVM.signInAnonymously()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
