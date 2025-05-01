//
//  HomeContent.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 7/4/25.
//

import SwiftUI

struct HomeContent: View {
    
    @Binding var path: [Routes]
    
    @State private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HomeTopBar(points: viewModel.totalPoints)
            
            if let lastUserGame = viewModel.lastUserGame {
                RecentQuizCard(
                    categoryImage: lastUserGame.categoryImage,
                    points: lastUserGame.points
                )
            }
            
            
            Text(LocalizedStringKey("categories"))
                .semiBoldStyle(size: 35)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.categories, id:\.id) { category in
                        Button {
                            path.append(Routes.Game)
                        } label: {
                            CategoryCell(category: category)
                        }
                    }
                }.padding(.bottom, 10)
            }
        }
        .padding(.horizontal, 20)
        .background(Color.Colors.background)
        .navigationBarBackButtonHidden()
        .onAppear {
            Task {
                try await viewModel.getTotalUserPoints()
            }
        }
    }
}

#Preview {
    HomeContent(path: .constant([]))
}
