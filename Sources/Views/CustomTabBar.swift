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
                .fill(Color.white)
                .shadow(radius: 5)
                .overlay(
                    TabBarShape()
                        .stroke(Color.orange, lineWidth: 2)
                )
            
            HStack(spacing: 25) {
                ForEach(0..<4) { index in
                    tabIcon(index: index)
                        .onTapGesture {
                            viewModel.selectTab(index)
                        }
                }
                Spacer().frame(width: 70)
            }
            .padding(.horizontal, 10)
        }
    }
    
    private func tabIcon(index: Int) -> some View {
        let icons = ["calendar", "doc.plaintext", "person.3", "person.crop.circle"]
        return Image(systemName: icons[index])
            .foregroundColor(viewModel.selectedTab == index ? .orange : .gray)
            .font(.system(size: 22))
    }
}

struct TabBarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cutoutRadius: CGFloat = 30
        let cutoutCenterX = rect.width / 2
        let cutoutTopY = rect.height - cutoutRadius * 2.5

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))

        path.addLine(to: CGPoint(x: cutoutCenterX - cutoutRadius * 2, y: rect.height))
        path.addQuadCurve(
            to: CGPoint(x: cutoutCenterX + cutoutRadius * 2, y: rect.height),
            control: CGPoint(x: cutoutCenterX, y: cutoutTopY)
        )

        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: 0))

        path.closeSubpath()
        return path
    }
}
