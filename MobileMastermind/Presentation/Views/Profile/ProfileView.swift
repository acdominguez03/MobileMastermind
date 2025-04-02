//
//  ProfileView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 3/4/25.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: Utils.shared.users[0].userImage)){ image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: 100,
                        height: 100
                    )
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            
            Text(Utils.shared.users[0].username)
                .mediumStyle(size: 20, color: .black)
            
            Text(verbatim: "acordon@gmail.com")
                .regularStyle(size: 15, color: .black)
                .padding(.bottom, 10)
            
            HStack(spacing: 15) {
                Spacer()
                
                UserGeneralStatComponent(image: .ProfileIcons.points, title: LocalizedStringKey("points"), description: "\(Utils.shared.users[0].points)", color: Color.Colors.questionErrorRed)
                
                Spacer()
                
                UserGeneralStatComponent(image: .ProfileIcons.bestScore, title: LocalizedStringKey("best_result"), description: "\(500)", color: Color.Colors.principalGreen)
                
                Spacer()
                
                UserGeneralStatComponent(image: .ProfileIcons.ranking, title: LocalizedStringKey("leaderboard"), description: "\(3)", color: Color.Colors.firstPlace)
                Spacer()
            }
            .padding(15)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
            )
            .padding(.horizontal, 15)
            
            Text("Estadísticas")
                .mediumStyle(size: 30, color: .black)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(Utils().stats) { stat in
                        CategoryStatsComponentsView(stat: stat)
                    }
                }
                .padding(.vertical, 15)
            }
            .background(.white)
            
        }
        .scrollIndicators(.hidden)
        .background(Color.Colors.background)
        
    }
}

#Preview {
    ProfileView()
}
