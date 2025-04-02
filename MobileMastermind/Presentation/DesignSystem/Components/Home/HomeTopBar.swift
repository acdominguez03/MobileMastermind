//
//  HomeTopBar.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct HomeTopBar: View {
    var username: String = "Andrés"
    var points: Int = 300
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Image("Profile")
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(LocalizedStringKey("hello"))
                    .mediumStyle(size: 14, color: .black)
                Text(username)
                    .boldStyle(size: 14, color: .black)
            }
            
            Spacer()
            
            Text(String(format: NSLocalizedString("points_message", comment: ""), points))
                .mediumStyle(size: 14, color: .black)
            
        }
    }
}

#Preview {
    HomeTopBar()
}
