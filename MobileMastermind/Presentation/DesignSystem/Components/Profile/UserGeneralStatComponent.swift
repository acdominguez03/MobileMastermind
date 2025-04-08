//
//  UserGeneralStatComponent.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 3/4/25.
//

import SwiftUI

struct UserGeneralStatComponent: View {
    let image: ImageResource
    let title: LocalizedStringKey
    let description: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(title)
                .regularStyle(size: 12, color: .black)
                .multilineTextAlignment(.center)
            
            Text(description)
                .boldStyle(size: 15, color: Color(color))
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    UserGeneralStatComponent(image: .ProfileIcons.points, title: "Points", description: "400", color: Color.Colors.questionErrorRed)
}
