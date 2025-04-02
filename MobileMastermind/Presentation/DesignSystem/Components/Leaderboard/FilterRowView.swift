//
//  FilterRowView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 2/4/25.
//

import SwiftUI

struct FilterRowView: View {
    var title: LocalizedStringKey
    var isSelected: Bool = false
    var onTapGesture: () -> Void
    
    var body: some View {
        VStack(spacing: 5) {
            if isSelected {
                Text(title)
                    .boldStyle(size: 15, color: Color.Colors.principalGreen)
            } else {
                Text(title)
                    .mediumStyle(size: 15, color: Color.Colors.secondPlace)
            }
                
            Rectangle()
                .fill(isSelected ? Color.Colors.principalGreen : Color.Colors.secondPlace)
                .frame(height: 4)
        }.onTapGesture {
            onTapGesture()
        }
    }
}


#Preview {
    FilterRowView(title: "Global", onTapGesture: {})
}
