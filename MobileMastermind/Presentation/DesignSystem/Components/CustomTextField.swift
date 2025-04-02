//
//  CustomSecureTextField.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct CustomTextField: View {
    static let eyeIcon: String = "eye"
    static let eyeSlashIcon: String = eyeIcon + ".slash"
    
    var title: LocalizedStringKey
    var placeholder: LocalizedStringKey
    var isSecureField: Bool = false
    @Binding var text: String
    @State var showText: Bool = false
    var onChange: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .mediumStyle(size: 14, color: .black)
            
            ZStack(alignment: .trailing) {
                
                if(showText) {
                    SecureField(placeholder, text: $text)
                        .textFieldStyle(CustomTextFieldStyle())
                } else {
                    TextField(placeholder, text: $text)
                        .textFieldStyle(CustomTextFieldStyle())
                        .onChange(of: text) { oldValue, newValue in
                            onChange()
                        }
                }

                Button(action: {
                    showText.toggle()
                }, label: {
                    Image(systemName: !showText ? CustomTextField.eyeSlashIcon: CustomTextField.eyeIcon)
                        .foregroundStyle(Color.Colors.placeholder)
                        .padding(12)
                })
                .opacity(isSecureField ? 1 : 0)
            }.animation(.easeInOut(duration: 0.3), value: showText)
        }
    }
}

#Preview {
    CustomTextField(title: "user", placeholder: "Introduce tu contraseña", text: .constant("Password"))
}
