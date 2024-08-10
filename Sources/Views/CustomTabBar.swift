//
//  CustomTabBar.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: CustomTabBarViewModel
    
    var body: some View {
        ZStack {
            TabBarShape()
                .fill(Color.white) // 탭 바 배경색
                .shadow(radius: 5)
            
            HStack(spacing: 60) {
                ForEach(0..<4) { index in
                    tabIcon(index: index)
                        .onTapGesture {
                            viewModel.selectTab(index)
                        }
                }
            }
            .padding(.horizontal, 40)
        }
    }
    
    private func tabIcon(index: Int) -> some View {
        let icons = ["calendar", "doc.text", "person.2", "person.crop.circle"]
        return Image(systemName: icons[index])
            .foregroundColor(.gray)
            .font(.system(size: 24))
    }
}

struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        let curveHeight: CGFloat = 35
        let curveWidth: CGFloat = 80
        let curveCenter = width / 2
        
        // 아치형 디자인 경로
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: curveCenter - curveWidth, y: 0))
        
        path.addQuadCurve(to: CGPoint(x: curveCenter + curveWidth, y: 0),
                          control: CGPoint(x: curveCenter, y: curveHeight))
        
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}
