//
//  MainView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct MainView: View {
    @State private var isChubby: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                CharacterView(isChubby: $isChubby)
                
                Text("Welcome to CheatDayMate!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                
                Text("Tap the cat or use the button to switch between Slim and Chubby mode!")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("CheatDayMate")
            .background(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).opacity(0.1).edgesIgnoringSafeArea(.all))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter())
    }
}
