//
//  ResultComponent.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct ResultComponent: View {
    let categoryName: String
    let points: Int
    let hits: Int
    let errors: Int
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text(NSLocalizedString("category", comment: ""))
                    .regularStyle(size: 20, color: .black)
                
                Text("\(categoryName)")
                    .boldStyle(size: 20, color: .black)
            }
            
            Text(String(format: NSLocalizedString("points_obtained", comment: ""), points))
                .boldStyle(size: 20, color: .black)
            
            HStack {
                Text("\(hits)")
                    .boldStyle(size: 30, color: .black)
                Image(.QuestionsIcons.successGreen)
                Text("\(errors)")
                    .boldStyle(size: 30, color: .black)
                Image(.QuestionsIcons.failedRed)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(radius: 20)
        )
    }
}

#Preview {
    ResultComponent(categoryName: "Kotlin", points: 140, hits: 7, errors: 3)
}
