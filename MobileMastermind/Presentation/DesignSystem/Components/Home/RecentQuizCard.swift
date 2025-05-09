//
//  RecentQuizView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct RecentQuizCard: View {
    var lastUserGame: LastUserGameBO
    
    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: lastUserGame.categoryImage)){ image in
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
                
                Text(String(format: NSLocalizedString("points_message", comment: ""), lastUserGame.points))
                    .boldStyle(size: 15, color: .white)
                
                Spacer()
            }
        }
        .frame(minHeight: 80)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: lastUserGame.categoryColor))
        )
    }
}

#Preview {
    RecentQuizCard(lastUserGame: LastUserGameBO(points: 0, categoryImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1745430027/zyj7bootmqyf61e0j8ug.png", categoryColor: "FF9931"))
}
