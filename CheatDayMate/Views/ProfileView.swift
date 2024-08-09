//
//  MyPageView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct MyPageView: View {
    @State private var userName = "User Name"
    @State private var weight = "70"
    @State private var height = "175"
    @State private var goalWeight = "65"
    @State private var notifications = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("프로필 정보")) {
                    TextField("이름", text: $userName)
                    TextField("체중 (kg)", text: $weight)
                        .keyboardType(.numberPad)
                    TextField("신장 (cm)", text: $height)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("목표 설정")) {
                    TextField("목표 체중 (kg)", text: $goalWeight)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("앱 설정")) {
                    Toggle("알림 받기", isOn: $notifications)
                    NavigationLink(destination: PrivacySettingsView()) {
                        Text("개인정보 설정")
                    }
                }
                
                Section {
                    Button("로그아웃") {
                        // 로그아웃 로직
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("마이페이지")
        }
    }
}

struct PrivacySettingsView: View {
    @State private var shareData = false
    
    var body: some View {
        Form {
            Toggle("데이터 공유", isOn: $shareData)
            Text("데이터 공유 설정을 통해 친구들과 정보를 공유할 수 있습니다.")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .navigationTitle("개인정보 설정")
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
            .environmentObject(MainViewModel())
    }
}
