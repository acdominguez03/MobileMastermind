//
//  RegisterView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

enum RegisterField {
    case username, email , password, repeatPassword
}

struct RegisterView: View {
    @Binding var path: [Routes]
    @State private var viewModel: RegisterViewModel = RegisterViewModel()
    
    @FocusState private var focusedField: RegisterField?
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text(LocalizedStringKey("register"))
                    .semiBoldStyle(size: 35)
                
                CameraSelector(photoSelection: $viewModel.photoSelection, image: viewModel.image)
                
                CustomTextField(title: LocalizedStringKey("user"), placeholder: LocalizedStringKey("introduce_your_user"), text: $viewModel.username)
                    .focused($focusedField, equals: .username)
                    .onSubmit {
                        focusedField = .email
                    }
                
                CustomTextField(
                    title: LocalizedStringKey("email"),
                    placeholder: LocalizedStringKey("introduce_your_email"),
                    text: $viewModel.email
                )
                .focused($focusedField, equals: .email)
                .onSubmit {
                    focusedField = .password
                }
                
                CustomTextField(
                    title: LocalizedStringKey("password"),
                    placeholder: LocalizedStringKey("introduce_your_pass"),
                    error: viewModel.error,
                    isSecureField: true,
                    text: $viewModel.password
                )
                .focused($focusedField, equals: .password)
                .onSubmit {
                    focusedField = .repeatPassword
                }
                
                CustomTextField(
                    title: LocalizedStringKey("repeat_password"),
                    placeholder: LocalizedStringKey("repeat_your_password"),
                    isSecureField: true,
                    text: $viewModel.repeatPassword
                )
                .focused($focusedField, equals: .repeatPassword)
                .onSubmit {
                    focusedField = nil
                }
                
                if !viewModel.error.isEmpty {
                    Text(viewModel.error)
                }
                
                let isDisabled = viewModel.username.isEmpty || viewModel.password.isEmpty || viewModel.repeatPassword.isEmpty || viewModel.email.isEmpty || viewModel.photoSelection == nil
                
                CustomButton(
                    title: LocalizedStringKey("register"),
                    isDisabled: isDisabled,
                    action: {
                        Task {
                            try await viewModel.registerUser {
                                path.append(Routes.Home)
                            }
                        }
                    }
                )
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text(LocalizedStringKey("already_have_an_account"))
                        .regularStyle(size: 14, color: .black)
                    
                    Button(action: {
                        path.removeLast()
                    }, label: {
                        Text(LocalizedStringKey("login"))
                            .boldStyle(size: 14, color: Color.Colors.principalGreen)
                    })
                }
            }
            .padding(.horizontal, 32)
            .background(Color.Colors.background)
            .navigationBarBackButtonHidden()
            
            LoadingView(isLoading: $viewModel.isLoading)
        }
    }
}

#Preview {
    RegisterView(path: .constant([]))
}
