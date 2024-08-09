//
//  FriendsView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct FriendsView: View {
    @State private var friends = ["Alice", "Bob", "Charlie", "David"]
    @State private var showingAddFriend = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(friends, id: \.self) { friend in
                    NavigationLink(destination: FriendDetailView(name: friend)) {
                        Text(friend)
                    }
                }
            }
            .navigationTitle("친구")
            .navigationBarItems(trailing: Button(action: {
                showingAddFriend = true
            }) {
                Image(systemName: "person.badge.plus")
            })
            .sheet(isPresented: $showingAddFriend) {
                AddFriendView()
            }
        }
    }
}

struct FriendDetailView: View {
    let name: String
    
    var body: some View {
        VStack {
            Text("\(name)의 활동")
                .font(.headline)
            List {
                Text("최근 운동: 조깅 30분")
                Text("목표 달성률: 80%")
                Text("최근 치팅 데이: 2024-08-05")
            }
        }
    }
}

struct AddFriendView: View {
    @State private var friendName = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("친구 이름", text: $friendName)
                Button("추가") {
                    // 친구 추가 로직
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("친구 추가")
            .navigationBarItems(trailing: Button("취소") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
            .environmentObject(MainViewModel())
    }
}
