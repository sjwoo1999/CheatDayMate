//
//  CharacterView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct CharacterView: View {
    @Binding var isChubby: Bool
    
    var body: some View {
        Image(isChubby ? "ChubbyCat" : "SlimCat")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onTapGesture {
                withAnimation {
                    isChubby.toggle()
                }
            }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(isChubby: .constant(false))
            .environmentObject(MainViewModel())
    }
}
