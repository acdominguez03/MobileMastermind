//
//  CustomAlert.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/5/25.
//

import SwiftUI

struct CustomAlert: View {
    var message: String = "Error en la conexión de red"
    var retry: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image(systemName: "icloud.slash")
                    .resizable()
                    .frame(width: 100, height: 92)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, minHeight: 150)
                    .background(Color.Colors.questionErrorRed)
                    
                   
                VStack {
                    Text(message)
                        .regularStyle(size: 20, color: .black)
                        
                    Button {
                        retry()
                    } label: {
                        Text("Reintentar")
                            .regularStyle(size: 20, color: .white)
                            .padding(10)
                            .background(Color.Colors.questionErrorRed)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 150)
                .background(Color.white)
                

            }
            .frame(maxWidth: .infinity, minHeight: 300)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    CustomAlert(retry: {})
}
