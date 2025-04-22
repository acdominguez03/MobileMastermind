//
//  LoginView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

enum Field {
    case username, password
}

struct LoginView: View {
    @Binding var path: [Routes]
    
    @State private var viewModel: LoginViewModel = LoginViewModel()
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 20) {
                
                Text("MOBILE MASTERMIND")
                    .titleStyle(size: 40)
                    .multilineTextAlignment(.center)
                
                CustomTextField(
                    title: LocalizedStringKey("user"),
                    placeholder:  LocalizedStringKey("introduce_your_user"),
                    text: $viewModel.username
                )
                .focused($focusedField, equals: .username)
                .onSubmit {
                    focusedField = .password
                }
                
                CustomTextField(
                    title: LocalizedStringKey("password"),
                    placeholder: LocalizedStringKey("introduce_your_pass"),
                    isSecureField: true,
                    text: $viewModel.password
                )
                .keyboardType(.numberPad)
                .focused($focusedField, equals: .password)
                .onSubmit {
                    focusedField = nil
                }
                
                let isDisabled = viewModel.username.isEmpty || viewModel.password.isEmpty
                
                CustomButton(
                    title: LocalizedStringKey("login"),
                    isDisabled: isDisabled
                ) {
                    focusedField = nil
                    Task {
                        try await viewModel.login {
                            path.append(Routes.Home)
                        }
                    }
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text(LocalizedStringKey("dont_have_an_account"))
                        .regularStyle(size: 14, color: .black)
                    
                    Button {
                        path.append(Routes.Register)
                    } label: {
                        Text(LocalizedStringKey("register")).boldStyle(size: 14, color: Color.Colors.principalGreen)
                    }
                }
            }
            .padding(.horizontal, 32)
            .background(Color.Colors.background)
            .navigationBarBackButtonHidden()
            .ignoresSafeArea(.keyboard)
            .onTapGesture {
                focusedField = nil
            }
            
            LoadingView(isLoading: $viewModel.isLoading)
        }
    }
}

#Preview {
    LoginView(path: .constant([]))
}
