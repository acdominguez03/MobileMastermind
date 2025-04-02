//
//  LeaderboardView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct LeaderboardView: View {
    var users: [UserModel] = Utils().users
    
    @State var isSelectedGlobalFilter: Bool = true
    @State var isSelectedCategoryFilter: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Text("Leaderboard")
                    .semiBoldStyle(size: 35)
                    .padding(.bottom, 20)
                
                HStack(spacing: 0) {
                    FilterRowView(
                        title: LocalizedStringKey("global"),
                        isSelected: isSelectedGlobalFilter,
                        onTapGesture: {
                            isSelectedGlobalFilter = true
                            isSelectedCategoryFilter = false
                        }
                    )
                    FilterRowView(
                        title: LocalizedStringKey("category"),
                        isSelected: isSelectedCategoryFilter,
                        onTapGesture: {
                            isSelectedCategoryFilter = true
                            isSelectedGlobalFilter = false
                        }
                    )
                }.containerRelativeFrame([.horizontal])
                
                HStack(alignment: .bottom) {
                    if(users.count > 1) {
                        TopThreeComponentView(
                            topThreePosition: .Second,
                            username: users[1].username,
                            points: 950,
                            userImage: users[1].userImage
                        )
                    }
                    
                    if(!users.isEmpty) {
                        TopThreeComponentView(
                            topThreePosition: .First,
                            username: users[0].username,
                            points: 1000,
                            userImage: users[0].userImage
                        )
                    }
                    
                    if(users.count > 2) {
                        TopThreeComponentView(
                            topThreePosition: .Third,
                            username: users[2].username,
                            points: 925,
                            userImage: users[2].userImage
                        )
                    }
                    
                }
                .padding(20)
                .containerRelativeFrame([.horizontal])
                .background(.white)
                .padding(.bottom, 20)
                
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(Array(users.enumerated()), id: \.offset) { (index, user) in
                            if(index > 2) {
                                if index == 5 {
                                    TopComponentView(
                                        username: user.username,
                                        points: user.points,
                                        isCurrentUser: true,
                                        position: index,
                                        userImage: user.userImage
                                    )
                                } else {
                                    TopComponentView(
                                        username: user.username,
                                        points: user.points,
                                        position: index,
                                        userImage: user.userImage
                                    )
                                }
                                
                            }
                        }
                    }
                }
                
            }
            .background(Color.Colors.background)
        }
        
    }
}

#Preview {
    LeaderboardView()
}
