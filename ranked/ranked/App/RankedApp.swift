//
//  rankedApp.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI
import Firebase

@main
struct rankedApp: App {
    @StateObject var authVM = AuthViewModel()
    @StateObject var viewModel: RankedAppViewModel
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeScreenView().environmentObject(authVM)
                .onOpenURL { url in
                    viewModel = RankedAppViewModel(url: url)
                    VoteScreenView(poll: viewModel.poll ?? onboardingPoll)
                }
        }
    }
}
