//
//  SignUpView.swift
//  CheatDayMate
//
//  Created by 우성종 on 8/10/24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Text("Create Account")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(Color(#colorLiteral(red: 0.1764705882, green: 0.1921568627, blue: 0.2588235294, alpha: 1)))
                
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                Button(action: {
                    // Perform sign up logic
                    viewRouter.currentPage = .home
                }) {
                    Text("Sign Up")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9843137255, green: 0.4156862745, blue: 0.01176470588, alpha: 1)), Color(#colorLiteral(red: 0.9960784314, green: 0.5490196078, blue: 0.1725490196, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                        )
                        .shadow(color: Color(#colorLiteral(red: 0.9843137255, green: 0.4156862745, blue: 0.01176470588, alpha: 1)).opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal)
                
                Button("Already have an account? Log In") {
                    viewRouter.currentPage = .login
                }
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.7607843137, blue: 0.7960784314, alpha: 1)))
                .font(.system(size: 16, weight: .medium, design: .rounded))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
            )
            .padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(ViewRouter())
    }
}
