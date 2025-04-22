//
//  ProfileView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 3/4/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var path: [Routes]
    @State var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                AsyncImage(url: URL(string: Utils.shared.users[0].userImage)){ image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: 150,
                            height: 150
                        )
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                
                Button {
                    Task {
                        try await viewModel.logout {
                            path.removeAll()
                        }
                    }
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.black)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .topTrailing)
                        .padding(.horizontal, 20)
                }
            }
            
            
            Text(Utils.shared.users[0].username)
                .mediumStyle(size: 30, color: .black)
            
            HStack(spacing: 15) {
                Spacer()
                
                UserGeneralStatComponent(image: .ProfileIcons.points, title: LocalizedStringKey("points"), description: "\(Utils.shared.users[0].points)", color: Color.Colors.questionErrorRed)
                
                Divider()
                    .frame(height: 70)
                    .background(Color.Colors.background)
                
                UserGeneralStatComponent(image: .ProfileIcons.bestScore, title: LocalizedStringKey("best_result"), description: "\(500)", color: Color.Colors.principalGreen)
                
                Divider()
                    .frame(height: 70)
                    .background(Color.Colors.background)
                
                UserGeneralStatComponent(image: .ProfileIcons.ranking, title: LocalizedStringKey("leaderboard"), description: "\(3)", color: Color.Colors.firstPlace)
                
                Spacer()
            }
            .padding(.vertical, 15)
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
    ProfileView(path: .constant([]))
}
