//
//  ResultsView.swift
//  ranked
//
//  Created by Valentin Silvera on 25/10/22.
//

import SwiftUI
import Charts

struct ResultsView: View {
    @ObservedObject var viewModel: ResultsViewModel
    @Environment(\.dismiss) private var dismiss // used for stacked navigation
    
    init(poll: Poll, votes: [Vote]) {
        self.viewModel = ResultsViewModel(poll: poll, votes: votes)
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
                    .foregroundColor(.white)
                
                Text("created by \(viewModel.poll.creator)")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                Spacer()
                
                // here is where we display the results
                // TODO: use real results instead of hard-coded ones
                TabView {
                    ForEach(0..<3) { i in
                        VStack(alignment: .leading) {
                            if i == 0 {
                                Text("Final Round")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                                AnimatedChart(results: sampleResultsRound3)
                                Spacer()
                            } else if i == 1 {
                                Text("Second Round")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                                AnimatedChart(results: sampleResultsRound2)
                                Spacer()
                            } else if i == 2 {
                                Text("First Round")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                                AnimatedChart(results: sampleResultsRound1)
                                Spacer()
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    }
                    .padding()
                }
                .frame(width: UIScreen.main.bounds.width, height: 500)
                .tabViewStyle(PageTabViewStyle())
                
                Text("Burger 🏆")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .horizontal])
                
                Text("with 11 votes")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                Spacer()
                
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
    }
    
    @ViewBuilder
    func AnimatedChart(results: [Result]) -> some View{
        Chart{
            ForEach(results) { item in
                BarMark(
                    x: .value("count", item.count),
                    y: .value("item", item.name)
                )
            }
        }
        .chartXScale(domain: ClosedRange(uncheckedBounds: (lower: 0, upper: 15)))
        .foregroundColor(.white)
//        .onAppear {
//            for (index,_) in sampleResults.enumerated() {
//                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
//                    withAnimation(.interactiveSpring(
//                        response: 0.8,
//                        dampingFraction: 0.8,
//                        blendDuration: 0.8)) {
//                            sampleResults[index].animate = true
//                        }
//                }
//            }
//        }
    }
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(poll: onboardingPoll, votes: [Vote(ballot: ["vote", "vote"])])
    }
}
