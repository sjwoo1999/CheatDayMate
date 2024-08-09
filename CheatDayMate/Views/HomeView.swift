//
//  MainTabView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var isChubby = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to CheatDayMate!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                CharacterView(isChubby: $isChubby)
                    .frame(height: 300)

                Button(action: {
                    withAnimation {
                        isChubby.toggle()
                    }
                }) {
                    Text(isChubby ? "Slim Down" : "Cheat Day!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(isChubby ? Color.green : Color.orange)
                        .cornerRadius(25)
                }
                .padding()

                NavigationLink(destination: CalendarView()) {
                    Text("View Calendar")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
            .navigationBarItems(trailing: NavigationLink(destination: MyPageView()) {
                Image(systemName: "person.circle")
                    .imageScale(.large)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MainViewModel())
    }
}
