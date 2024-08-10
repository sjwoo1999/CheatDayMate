//
//  SplashScreenView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/11/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var logoOffset: CGFloat = 200 // 초기 오프셋 (화면 하단에서 시작)
    @State private var navigateToHome = false // HomeTabView로의 네비게이션 플래그

    var body: some View {
        if navigateToHome {
            HomeTabView() // 네비게이션 플래그가 true가 되면 HomeTabView로 이동
        } else {
            ZStack {
                Color(hex: "FA833F").edgesIgnoringSafeArea(.all) // 배경 색상

                Image("CheatDayMateLogo") // 로고 이미지
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .offset(y: logoOffset) // 오프셋을 적용해 로고의 위치를 조정
                    .onAppear {
                        startAnimation()
                    }
            }
        }
    }

    // 애니메이션과 화면 전환을 관리하는 함수
    private func startAnimation() {
        withAnimation(.easeOut(duration: 1.0)) {
            logoOffset = 0 // 로고를 화면 중앙으로 이동
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // 애니메이션 1초 + 유지 1초
            withAnimation {
                navigateToHome = true // HomeTabView로 이동
            }
        }
    }
}

// Color 확장을 통해 hex 값을 사용할 수 있도록 함
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 08) & 0xFF) / 255.0
        let b = Double((rgb >> 00) & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
