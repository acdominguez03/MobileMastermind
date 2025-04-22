//
//  HomeTopBar.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct HomeTopBar: View {
    @State var username: String = "Andrés"
    @State var image: String = "Profile"
    var points: Int = 300
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            AsyncImage(url: URL(string: image)){ image in
                image.resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
            
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
        .onAppear {
            username = MobileMastermindDefaultsManager.shared.username
            image = MobileMastermindDefaultsManager.shared.imageURL
        }
    }
}

#Preview {
    HomeTopBar()
}
