//
//  CalendarPopupView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct CalendarPopupView: View {
    @Binding var isShowing: Bool
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            Text("치팅데이를 선택해주세요!")
                .font(.headline)
            
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
            
            Button("확인") {
                // 선택된 날짜 처리 로직
                isShowing = false
            }
            .padding()
            .background(Color(#colorLiteral(red: 0.9843137255, green: 0.4156862745, blue: 0.01176470588, alpha: 1)))
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button("취소") {
                isShowing = false
            }
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct CalendarPopupView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPopupView(isShowing: .constant(true))
    }
}
