//
//  HomeContent.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 7/4/25.
//

import SwiftUI

struct HomeContent: View {
    
    @Binding var path: [Routes]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HomeTopBar()
            
            RecentQuizCard()
            
            Text(LocalizedStringKey("categories"))
                .semiBoldStyle(size: 35)
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(Utils.shared.categories) { category in
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
    }
}

#Preview {
    HomeContent(path: .constant([]))
}
