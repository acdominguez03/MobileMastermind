//
//  SecureTextFieldStyle.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .regularStyle(size: 14, color: Color.black)
            .foregroundStyle(Color("Placeholder"))
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
    }
}
