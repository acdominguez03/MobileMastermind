//
//  TopThreeComponentView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

enum TopThreePositions {
    case First
    case Second
    case Third
    
    var icon: ImageResource {
        switch self {
        case .First:
            return .LeaderboardIcons.firstPlace
        case .Second:
            return .LeaderboardIcons.secondPlace
        case .Third:
            return .LeaderboardIcons.thirdPlace
        }
    }
}

struct TopThreeComponentView: View {
    
    var topThreePosition: TopThreePositions
    
    var username: String
    var points: Int
    
    var userImage: String
    
    var isCurrentUser: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            
            if(topThreePosition == TopThreePositions.First) {
                Image(.LeaderboardIcons.crown)
                    .resizable()
                    .frame(width: 40, height: 35)
            }
            
            ZStack(alignment: .bottom) {
                AsyncImage(url: URL(string: userImage)){ image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: topThreePosition == TopThreePositions.First ? 150 : 100,
                            height: topThreePosition == TopThreePositions.First ? 150 : 100
                        )
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(getPositionColor(topThreePosition: topThreePosition), lineWidth: 3)
                        )
                } placeholder: {
                    ProgressView()
                }
                
                ZStack {
                    Circle()
                        .foregroundStyle(getPositionColor(topThreePosition: topThreePosition))
                        .frame(
                            width: topThreePosition == TopThreePositions.First ? 30 + 20 : 20 + 20,
                            height: topThreePosition == TopThreePositions.First ? 30 + 20 : 20 + 20
                        )
                    
                    Image(topThreePosition.icon)
                        .resizable()
                        .frame(
                            width: topThreePosition == TopThreePositions.First ? 30 : 20,
                            height: topThreePosition == TopThreePositions.First ? 30 : 20
                        )
                }
                .offset(y: 15)
            }
            .padding(.bottom, 15)
            
            VStack {
                Text("\(isCurrentUser ? "Tú" : username)")
                    .mediumStyle(size: 20, color: .black)
                Text(String(format: NSLocalizedString("points_message", comment: ""), points))
                    .mediumStyle(size: 15, color: .black)
            }
        }
    }
}

func getPositionColor(topThreePosition: TopThreePositions) -> Color {
    switch topThreePosition {
        case .First:
            return Color.Colors.firstPlace
        case .Second:
            return Color.Colors.secondPlace
        case .Third:
            return Color.Colors.thirdPlace
    }
}

#Preview {
    TopThreeComponentView(topThreePosition: .First, username: "David", points: 1000, userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1729874344/fe9db982af7848e2fe9851a9b838951f_hllslr.jpg")
}

