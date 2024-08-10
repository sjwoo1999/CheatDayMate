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
    @State private var blurRadius: CGFloat = 0
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                // 상단에 테스트용 버튼 배치
                HStack {
                    Button(action: {
                        viewModel.addCalories(-10000)
                    }) {
                        Text("-10,000 칼로리")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.addCalories(10000)
                    }) {
                        Text("+10,000 칼로리")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // 칼로리, 프로그레스 바, 고양이, 메시지를 중앙으로 배치
                // 추후 여기에 D-Day 설정해두기
                VStack(spacing: 16) {
                    Text("오늘은? \(viewModel.formattedDate)")
                        .font(.headline)
                        .foregroundColor(.orange)
                    
                    // 칼로리 프로그레스 바
                    ProgressView(value: Double(viewModel.currentCalories), total: Double(viewModel.goalCalories))
                        .progressViewStyle(CalorieProgressStyle())
                    
                    Image(viewModel.catImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                    
                    // 말풍선 메시지
                    Text(viewModel.catMessage)
                        .font(.system(size: 18, weight: .medium))
                        .padding()
                        .background(Color.white)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.orange, lineWidth: 2))
                        .multilineTextAlignment(.center) // 텍스트 가운데 정렬
                        .padding()
                }
                .padding()
                
                Spacer()
                
                // Custom Tab Bar with the "+" button at the top of the arch
                ZStack {
                    CustomTabBar(viewModel: viewModel.tabBarViewModel)
                        .frame(height: 70)
                        .background(Color.white)
                        .clipShape(TabBarShape()) // 아치형 디자인
                        .shadow(radius: 5)
                    
                    // 플러스 버튼을 아치형 디자인 위에 배치
                    Button(action: {
                        withAnimation(.spring()) {
                            showInputView = true
                            blurRadius = 10
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 70, height: 70)
                            .background(Color.orange)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .offset(y: -60) // 플러스 버튼을 더 위로 올림
                }
                .padding(.bottom, 40) // 홈 인디케이터와의 간격 추가 확보
            }
            .blur(radius: blurRadius)
            
            // InputView
            if showInputView {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showInputView = false
                            blurRadius = 0
                        }
                    }
                
                InputView(isPresented: $showInputView, blurRadius: $blurRadius, addCalories: { calories in
                    print("칼로리 추가됨")
                }).transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true) // Back 버튼 숨기기
    }
}

struct CalorieProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 14)
                .frame(height: 28)
                .foregroundColor(.orange.opacity(0.3))
            
            RoundedRectangle(cornerRadius: 14)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * UIScreen.main.bounds.width * 0.9, height: 28)
                .foregroundColor(.orange)
            
            HStack {
                Spacer()
                Text("\(Int((configuration.fractionCompleted ?? 0) * 150000)) / 150,000")
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(.trailing, 8)
            }
        }
        .frame(height: 30)
    }
}
