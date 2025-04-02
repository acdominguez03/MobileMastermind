//
//  RegisterView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("register"))
                .semiBoldStyle(size: 35)
            
            CameraSelector(photoSelection: .constant(nil), image: Image(.profile))
            
            CustomTextField(title: LocalizedStringKey("user"), placeholder: LocalizedStringKey("introduce_your_user"), text: $username)
            
            CustomTextField(
                title: LocalizedStringKey("email"),
                placeholder: LocalizedStringKey("introduce_your_email"),
                text: $email
            )
            
            CustomTextField(
                title: LocalizedStringKey("password"),
                placeholder: LocalizedStringKey("introduce_your_pass"),
                text: $password
            )
            
            CustomTextField(
                title: LocalizedStringKey("repeat_password"),
                placeholder: LocalizedStringKey("repeat_your_password"),
                text: $repeatPassword
            )
            
            let isDisabled = username.isEmpty || password.isEmpty || repeatPassword.isEmpty || email.isEmpty
            
            CustomButton(
                title: LocalizedStringKey("register"),
                isDisabled: isDisabled,
                action: {
                }
            )
            
            Spacer()
            
            HStack(spacing: 0) {
                Text(LocalizedStringKey("already_have_an_account"))
                    .regularStyle(size: 14, color: .black)
                
                Button(action: {
                    
                }, label: {
                    Text(LocalizedStringKey("login"))
                        .boldStyle(size: 14, color: Color.Colors.principalGreen)
                })
            }
        }
        .padding(.horizontal, 32)
        .background(Color.Colors.background)
    }
}

#Preview {
    RegisterView()
}
