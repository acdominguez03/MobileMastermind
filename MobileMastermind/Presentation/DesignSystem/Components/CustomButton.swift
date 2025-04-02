//
//  CustomButton.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct CustomButton: View {
    var title: LocalizedStringKey
    var isDisabled: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .regularButtonStyle()
                .frame(maxWidth: .infinity)
                .padding(10)
        }
        .disabled(isDisabled)
        .foregroundStyle(.white)
        .background(isDisabled ? Color.Colors.backgroundResponse : Color.Colors.principalGreen)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    CustomButton(title: "Iniciar Sesión", isDisabled: false, action: {})
}
