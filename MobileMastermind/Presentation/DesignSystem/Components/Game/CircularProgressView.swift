//
//  CircularProgressView.swift
//  MobileMastermind
//
//  Created by Andres Cordón on 1/4/25.
//

import SwiftUI

struct CircularProgressView: View {
    var timeRemaining: Int

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var progress: CGFloat
    
    var updateTime: () -> Void

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.Colors.principalGreen.opacity(0.5),
                    lineWidth: 5
            )
            
            Circle()
                .trim(from: 0.00, to: progress)
                .stroke(
                    Color.Colors.principalGreen,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round
                    )
                ).rotationEffect(.degrees(-90))
                
            
            Text("\(timeRemaining)")
                .mediumStyle(size: 30, color: .black)
                
        }
        .frame(width: 100, height: 100)
        .onAppear {
            updateTime()
        }
    }
}

#Preview {
    CircularProgressView(timeRemaining: 30, progress: 0, updateTime: {})
}
