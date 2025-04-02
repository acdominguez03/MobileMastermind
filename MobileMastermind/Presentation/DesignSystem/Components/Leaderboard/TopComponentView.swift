//
//  TopComponentView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct TopComponentView: View {
    var username: String
    var points: Int
    var isCurrentUser: Bool = false
    var position: Int
    var userImage: String
    
    var body: some View {
        HStack(spacing: 15) {
            Text("\(position)")
                .regularStyle(size: 20, color: isCurrentUser ? .white : .black)
            
            AsyncImage(url: URL(string: userImage)){ image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: 60,
                        height: 60
                    )
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            
            Text(username)
                .regularStyle(size: 20, color: isCurrentUser ? .white : .black)
            
            Spacer()
            
            Text(String(format: NSLocalizedString("points_message", comment: ""), points))
                .regularStyle(size: 15, color: isCurrentUser ? .white : .black)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isCurrentUser ? Color.Colors.principalGreen : .white)
        )
    }
}

#Preview {
    TopComponentView(username: "Luna", points: 800, position: 4, userImage: "https://res.cloudinary.com/dnuejyham/image/upload/v1729874344/fe9db982af7848e2fe9851a9b838951f_hllslr.jp")
}
