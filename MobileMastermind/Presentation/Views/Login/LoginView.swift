//
//  LoginView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("MOBILE MASTERMIND")
                .titleStyle(size: 40)
                .multilineTextAlignment(.center)
            
            CustomTextField(title: LocalizedStringKey("user"), placeholder:  LocalizedStringKey("introduce_your_user"), text: $username)
            
            CustomTextField(title: LocalizedStringKey("password"),placeholder: LocalizedStringKey("introduce_your_pass"), text: $password)
            
            HStack(spacing: 0) {
                Text(LocalizedStringKey("forgot_pass"))
                    .regularStyle(size: 14, color: .black)
                Text(LocalizedStringKey("pass?"))
                    .boldStyle(size: 14, color: Color.Colors.principalGreen)
            }
            
            let isDisabled = username.isEmpty || password.isEmpty
            
            CustomButton(
                title: LocalizedStringKey("login"),
                isDisabled: isDisabled
            ) {}
            
            Spacer()
            
            HStack(spacing: 0) {
                Text(LocalizedStringKey("dont_have_an_account"))
                    .regularStyle(size: 14, color: .black)
                Text(LocalizedStringKey("register")).boldStyle(size: 14, color: Color.Colors.principalGreen)
            }
        }
        .padding(.horizontal, 32)
        .background(Color.Colors.background)
    }
}

#Preview {
    LoginView()
}
