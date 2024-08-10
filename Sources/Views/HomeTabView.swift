//
//  HomeTabView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct HomeTabView: View {
    @StateObject private var viewModel = HomeTabViewModel()
    @State private var showInputView = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 20)
                
                // 상단의 내용 영역
                VStack(spacing: 16) {
                    Text("2-Day \(viewModel.formattedDate)")
                        .font(.headline)
                        .foregroundColor(.orange)
                    
                    // 칼로리 프로그레스 바
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.purple.opacity(0.3))
                        Capsule()
                            .fill(Color.orange)
                            .frame(width: CGFloat(viewModel.currentCalories) / CGFloat(viewModel.goalCalories) * UIScreen.main.bounds.width * 0.8)
                    }
                    .frame(height: 30)
                    .overlay(
                        Text("\(viewModel.currentCalories) / \(viewModel.goalCalories)")
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                    
                    Image(viewModel.catImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                    
                    Text(viewModel.catMessage)
                        .font(.system(size: 18, weight: .medium))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                }
                .padding()
                
                Spacer()
                
                // 하단 바 및 플러스 버튼
                ZStack {
                    CustomTabBar(viewModel: viewModel.tabBarViewModel)
                        .frame(height: 70)
                    
                    Button(action: {
                        showInputView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.orange)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .offset(y: -30)
                }
            }
            .background(Color(UIColor(red: 1.0, green: 0.98, blue: 0.77, alpha: 1.0)))
            
            if showInputView {
                InputView(isPresented: $showInputView, addCalories: viewModel.addCalories)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: showInputView)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct InputView: View {
    @Binding var isPresented: Bool
    var addCalories: (Int) -> Void
    @State private var selectedType: String?
    
    var body: some View {
        VStack {
            Text("무엇을 기록할까요?")
                .font(.headline)
                .padding()
            
            Button("식단") {
                selectedType = "식단"
                addCalories(500)  // 예시로 500 칼로리 추가
                isPresented = false
            }
            .buttonStyle(InputButtonStyle())
            
            Button("운동") {
                selectedType = "운동"
                addCalories(-300)  // 예시로 300 칼로리 감소
                isPresented = false
            }
            .buttonStyle(InputButtonStyle())
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.orange)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct InputButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(10)
            .padding(.horizontal)
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
