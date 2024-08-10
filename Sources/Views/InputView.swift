//
//  InputView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct InputView: View {
    @Binding var isPresented: Bool
    @Binding var blurRadius: CGFloat
    var addCalories: (Int) -> Void
    @State private var offset: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                VStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 3)
            //            .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 6)
                        .padding(.top, 8)
                    
                    Text("무엇을 기록할까요?")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Button("식단") {
                        addCalories(500)
                        dismissView()
                    }
                    .buttonStyle(InputButtonStyle())
                    
                    Button("운동") {
                        addCalories(-300)
                        dismissView()
                    }
                    .buttonStyle(InputButtonStyle())
                    
                    Spacer()
                }
                .frame(height: geometry.size.height * 0.4)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                
                Rectangle()
                    .fill(Color.orange)
                    .frame(height: geometry.safeAreaInsets.bottom)
            }
            .offset(y: offset)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(.spring()) {
                offset = 0
            }
        }
    }
    
    private func dismissView() {
        withAnimation(.spring()) {
            offset = UIScreen.main.bounds.height
            blurRadius = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
        }
    }
}

struct InputButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.orange)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
