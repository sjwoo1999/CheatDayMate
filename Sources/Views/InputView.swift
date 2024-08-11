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
    @ObservedObject var dietRecordViewModel: DietRecordViewModel
    @State private var offset: CGFloat = UIScreen.main.bounds.height
    @State private var showDietRecordView = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                VStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width: 40, height: 6)
                        .padding(.top, 8)
                    
                    Text("무엇을 기록할까요?")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Button("식단") {
                        showDietRecordView = true
                    }
                    .buttonStyle(InputButtonStyle())
                    
                    Button("운동") {
                        // 운동 기록 로직 (아직 구현되지 않음)
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
        .fullScreenCover(isPresented: $showDietRecordView) {
            DietRecordView(viewModel: dietRecordViewModel, isPresented: $showDietRecordView, showAddMealImmediately: true)
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
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.orange)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = CGFloat.infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// 예시: horizontal 사용
// .padding(.horizontal, 10)
