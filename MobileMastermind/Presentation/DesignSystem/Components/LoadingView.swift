//
//  LoadingView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 21/4/25.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool
    var body: some View {
        if (isLoading) {
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black.opacity(0.3))
        }
    }
}

#Preview {
    LoadingView(isLoading: .constant(true))
}
