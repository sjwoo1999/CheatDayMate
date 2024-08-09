//
//  CalendarView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @State private var cheatDays: [Date] = []
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .accentColor(Color(#colorLiteral(red: 0.9843137255, green: 0.4156862745, blue: 0.01176470588, alpha: 1)))
                    .padding()
                
                if cheatDays.contains(selectedDate) {
                    CheatDayDetailsView(date: selectedDate)
                } else {
                    RegularDayView(date: selectedDate)
                }
                
                Spacer()
                
                Button(action: {
                    toggleCheatDay()
                }) {
                    Text(cheatDays.contains(selectedDate) ? "Remove Cheat Day" : "Mark as Cheat Day")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9843137255, green: 0.4156862745, blue: 0.01176470588, alpha: 1)), Color(#colorLiteral(red: 0.9960784314, green: 0.5490196078, blue: 0.1725490196, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                        )
                        .shadow(color: Color(#colorLiteral(red: 0.9843137255, green: 0.4156862745, blue: 0.01176470588, alpha: 1)).opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding()
            }
            .navigationTitle("Calendar")
            .background(Color(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)))
        }
    }
    
    func toggleCheatDay() {
        if let index = cheatDays.firstIndex(of: selectedDate) {
            cheatDays.remove(at: index)
        } else {
            cheatDays.append(selectedDate)
        }
    }
}

struct CheatDayDetailsView: View {
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Cheat Day")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color(#colorLiteral(red: 0.9843137255, green: 0.4156862745, blue: 0.01176470588, alpha: 1)))
            
            Text("Enjoy your treats responsibly!")
                .font(.system(size: 18, weight: .medium, design: .rounded))
            
            Text("Remember to log your meals and get back on track tomorrow.")
                .font(.system(size: 16, design: .rounded))
                .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct RegularDayView: View {
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Regular Day")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.7607843137, blue: 0.7960784314, alpha: 1)))
            
            Text("Stay focused on your goals!")
                .font(.system(size: 18, weight: .medium, design: .rounded))
            
            Text("Log your meals and workouts to keep track of your progress.")
                .font(.system(size: 16, design: .rounded))
                .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
