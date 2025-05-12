//
//  LeaderboardView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct RankingView: View {
    
    @State private var viewModel: RankingViewModel = RankingViewModel()
    
    @State var isSelectedGlobalFilter: Bool = true
    @State var isSelectedCategoryFilter: Bool = false
    
    @State private var currentUserIndex: Int?
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text(LocalizedStringKey("leaderboard"))
                    .semiBoldStyle(size: 35)
                    .padding(.bottom, 20)
                
                /*HStack(spacing: 0) {
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
                 }.containerRelativeFrame([.horizontal])*/
                
                HStack(alignment: .bottom) {
                    let topPositions: [(index: Int, position: TopThreePositions)] = [
                        (1, .Second),
                        (0, .First),
                        (2, .Third)
                    ]
                    
                    ForEach(topPositions, id: \.index) { item in
                        if viewModel.userRankings.indices.contains(item.index) {
                            let user = viewModel.userRankings[item.index].user
                            TopThreeComponentView(
                                topThreePosition: item.position,
                                username: user.username,
                                points: viewModel.userRankings[item.index].totalScore,
                                userImage: user.image,
                                isCurrentUser: user.username == MobileMastermindDefaultsManager.shared.username
                            )
                        }
                    }
                    
                    
                }
                .padding(10)
                .containerRelativeFrame([.horizontal])
                .background(.white)
                .padding(.bottom, 20)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(Array(viewModel.userRankings.enumerated()), id: \.offset) { (index, userRanking) in
                                
                                let isCurrentUser = userRanking.user.username == MobileMastermindDefaultsManager.shared.username
                                
                                if index > 2 {
                                    TopComponentView(
                                        username: userRanking.user.username,
                                        points: userRanking.totalScore,
                                        isCurrentUser: isCurrentUser,
                                        position: index + 1,
                                        userImage: userRanking.user.image
                                    )
                                    .padding(.horizontal, 8)
                                    .id(index)
                                }
                            }
                        }
                    }
                    .onChange(of: viewModel.userRankings) {
                        if let index = viewModel.userRankings.firstIndex(where: {
                            $0.user.username == MobileMastermindDefaultsManager.shared.username
                        }) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation {
                                    proxy.scrollTo(index, anchor: .center)
                                    print("Haciendo scroll al índice \(index)")
                                }
                            }
                        }
                    }
                }
            }
            .background(Color.Colors.background)
            .onAppear {
                Task {
                    try await viewModel.getUsersRanking()
                }
            }
            
            LoadingView(isLoading: $viewModel.isLoading)
        }
    }
}

#Preview {
    RankingView()
}
