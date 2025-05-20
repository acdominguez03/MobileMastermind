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
        ZStack {
            VStack(alignment: .leading, spacing: 30) {
                HomeTopBar(points: viewModel.totalPoints)
                
                if let lastUserGame = viewModel.lastUserGame {
                    RecentQuizCard(
                        lastUserGame: lastUserGame
                    )
                }
                
                Text(LocalizedStringKey("categories"))
                    .semiBoldStyle(size: 35)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.categories, id:\.id) { category in
                            Button {
                                path.append(Routes.Game(categoryId: category.id, categoryName: category.name))
                            } label: {
                                CategoryCell(
                                    category: category,
                                    navigateToGameView: {
                                        path.append(Routes.Game(categoryId: category.id, categoryName: category.name))
                                    }
                                )
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
            
            LoadingView(isLoading: $viewModel.isLoading)
            
            if(viewModel.errorType != nil && viewModel.errorType != HomeErrors.tokenExpired) {
                CustomAlert(message: viewModel.errorMessage, retry: {
                    Task {
                        try await viewModel.getTotalUserPoints()
                    }
                })
            }
        }
        .onChange(of: viewModel.errorType) { oldValue, newValue in
            if(newValue == HomeErrors.tokenExpired) {
                path.removeAll()
            }
        }
    }
}

#Preview {
    HomeContent(path: .constant([]))
}
