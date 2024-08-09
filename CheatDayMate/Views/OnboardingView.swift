//
//  OnboardingView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var currentPage = 0
    let pages = ["Welcome to CheatDayMate", "Track Your Progress", "Stay Motivated"]

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                    VStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.orange)
                        Text(pages[index])
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

            Button(action: {
                if currentPage < pages.count - 1 {
                    withAnimation {
                        currentPage += 1
                    }
                } else {
                    withAnimation {
                        viewRouter.navigateToHome()
                    }
                }
            }) {
                Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.orange)
                    .cornerRadius(25)
            }
            .padding()

            if currentPage < pages.count - 1 {
                Button("Skip") {
                    withAnimation {
                        viewRouter.navigateToHome()
                    }
                }
                .foregroundColor(.gray)
            }
        }
        .transition(.slide)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(ViewRouter())
    }
}
