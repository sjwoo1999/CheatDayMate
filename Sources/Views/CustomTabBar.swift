//
//  CustomTabBar.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: CustomTabBarViewModel
    var onPlusButtonTap: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 탭바 본체
                TabBarShape()
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
                    .frame(height: 60)
                
                // 아이콘
                HStack(spacing: 0) {
                    ForEach(0..<5) { index in
                        if index == 2 {
                            Spacer().frame(width: geometry.size.width / 5)
                        } else {
                            tabIcon(index: index < 2 ? index : index - 1)
                                .frame(width: geometry.size.width / 5)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        viewModel.selectTab(index < 2 ? index : index - 1)
                                    }
                                }
                        }
                    }
                }
                
                // 중앙 '+' 버튼
                Button(action: onPlusButtonTap) {
                    ZStack {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 56, height: 56)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .offset(y: -50)
            }
        }
        .frame(height: 60)
    }
    
    private func tabIcon(index: Int) -> some View {
        let icons = ["calendar", "doc.text", "person.2", "person.crop.circle"]
        return VStack(spacing: 4) {
            Image(systemName: icons[index])
                .foregroundColor(viewModel.selectedTab == index ? .orange : .gray)
                .font(.system(size: 20))
            
            Circle()
                .fill(viewModel.selectedTab == index ? Color.orange : Color.clear)
                .frame(width: 4, height: 4)
        }
        .frame(height: 60)
    }
}

struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let cornerRadius: CGFloat = 20
        let archHeight: CGFloat = 30 // 줄어든 아치 높이
        let archWidth: CGFloat = 80 // 줄어든 아치 너비
        let archCenterX = width / 2
        
        // 시작점 (왼쪽 상단)
        path.move(to: CGPoint(x: 0, y: cornerRadius))
        
        // 왼쪽 상단 모서리
        path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 270),
                    clockwise: false)
        
        // 왼쪽 상단에서 아치 시작점까지
        path.addLine(to: CGPoint(x: archCenterX - archWidth/2, y: 0))
        
        // U자형 아치 (3차 베지어 곡선 사용)
        let controlPoint1 = CGPoint(x: archCenterX - archWidth/4, y: archHeight)
        let controlPoint2 = CGPoint(x: archCenterX + archWidth/4, y: archHeight)
        path.addCurve(to: CGPoint(x: archCenterX + archWidth/2, y: 0),
                      control1: controlPoint1,
                      control2: controlPoint2)
        
        // 아치 끝점에서 오른쪽 상단까지
        path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
        
        // 오른쪽 상단 모서리
        path.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 270),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)
        
        // 오른쪽 가장자리
        path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
        
        // 오른쪽 하단 모서리
        path.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)
        
        // 하단 가장자리
        path.addLine(to: CGPoint(x: cornerRadius, y: height))
        
        // 왼쪽 하단 모서리
        path.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 180),
                    clockwise: false)
        
        // 왼쪽 가장자리로 돌아가기
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        
        return path
    }
}
