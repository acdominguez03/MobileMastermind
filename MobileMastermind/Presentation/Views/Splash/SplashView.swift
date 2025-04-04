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
                case .Game:
                    GameView(path: $path)
                case .GameResults:
                    GameResultsView(path: $path)
                case .Leaderboard:
                    LeaderboardView()
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
