//
//  HomeView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HomeTopBar()
            
            RecentQuizCard()

            Text(LocalizedStringKey("categories"))
                .semiBoldStyle(size: 35)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(Utils.shared.categories) { category in
                        CategoryCell(category: category)
                    }
                }.padding(.bottom, 10)
            }
        }
        .padding(.horizontal, 20)
        .background(Color.Colors.background)
    }
}

#Preview {
    HomeView()
}
