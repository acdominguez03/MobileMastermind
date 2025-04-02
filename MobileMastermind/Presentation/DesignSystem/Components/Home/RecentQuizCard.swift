//
//  RecentQuizView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct RecentQuizCard: View {
    var categoryImage: String = "https://res.cloudinary.com/dnuejyham/image/upload/v1743541421/swift_q2pmwe.png"
    var points: Int = 300
    var categoryName: String = "Kotlin"
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: categoryImage)){ image in
                image.resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(.rect(topLeadingRadius: 10, bottomLeadingRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            HStack {
                Text(LocalizedStringKey("last_game"))
                    .regularStyle(size: 15, color: .white)
                
                Text(String(format: NSLocalizedString("points_message", comment: ""), points))
                    .boldStyle(size: 15, color: .white)
                
                Spacer()
            }
        }
        .frame(minHeight: 80)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.Colors.principalGreen)
        )
    }
}

#Preview {
    RecentQuizCard()
}
