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
                        PollPreviewView(poll: onboardingPoll)
                        ForEach(viewModel.polls) { poll in
                            PollPreviewView(poll: poll)
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
        .accentColor(.white)
        .onAppear() {
            authVM.signInAnonymously()
        }
    }
}
