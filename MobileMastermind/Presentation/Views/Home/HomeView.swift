//
//  HomeView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var path: [Routes]
    @State var selectedTab = 0
    @State private var isTabBarEnabled: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeContent(path: $path)
                    .tag(0)
                
                LeaderboardView()
                    .tag(1)
                
                ProfileView(path: $path)
                    .tag(2)
            }
            
            if(isTabBarEnabled) {
                ZStack {
                    HStack {
                        ForEach(TabbedItems.allCases, id: \.self) { item in
                            Button {
                                selectedTab = item.rawValue
                            } label: {
                                Spacer()
                                CustomTabItem(imageName: item.iconName, title: item.title, isActive: selectedTab == item.rawValue)
                                Spacer()
                            }
                        }
                    }.padding(6)
                }
                .padding(10)
                .background(Color.Colors.tabView)
                .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
    }
}

extension HomeView {
    func CustomTabItem(imageName: ImageResource, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            Image(imageName)
                .resizable()
                .foregroundStyle(isActive ? .white : Color.Colors.backgroundResponse)
                .frame(width: 20, height: 20)
            
            if(isActive) {
                Text(title)
                    .mediumStyle(size: 15, color: .white)
            }
            Spacer()
        }.frame(width: isActive ? 150 : 60, height: 50)
            .background(isActive ? Color.Colors.principalGreen : .clear)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}



#Preview {
    HomeView(path: .constant([]))
}
