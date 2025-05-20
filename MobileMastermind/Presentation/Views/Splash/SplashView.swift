//
//  SplashView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 3/4/25.
//

import SwiftUI

struct SplashView: View {
    @State private var path: [Routes] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.Colors.background.ignoresSafeArea()
                
                Image(.logo)
                    .resizable()
                    .scaledToFit()
            }
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .Login:
                    LoginView(path: $path)
                case .Register:
                    RegisterView(path: $path)
                case .Home:
                    HomeView(path: $path)
                case .Game(let categoryId, let categoryName):
                    GameView(path: $path, categoryId: categoryId, categoryName: categoryName)
                case .GameResults(let questionsJson, let gameId, let categoryName):
                    GameResultsView(path: $path, questionsJson: questionsJson, gameId: gameId, categoryName: categoryName)
                case .Leaderboard:
                    RankingView(path: $path)
                case .Profile:
                    ProfileView(path: $path)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    path.append(Routes.Login)
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
