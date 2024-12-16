//
//  SplashScreenView.swift
//  Currency Converter
//
//  Created by An Luu on 15/12/24.
//

import SwiftUI

/// A splash screen before HomeView
struct SplashScreenView: View {
    
    /// State variable to control the design and visibility
    @State private var isActive: Bool = false
    @State private var logoScale: CGFloat = 0.8
    @State private var opacity: Double = 0.5

    var body: some View {
        if isActive {
            HomeView() // The main content view after splash screen
        } else {
            VStack {
                Image("splashArt")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.blue)
                    .scaleEffect(logoScale)
                    .opacity(opacity)
                    .onAppear {
                        // Add scaling and fading animations
                        withAnimation(.easeIn(duration: 1.5)) {
                            logoScale = 1.0
                            opacity = 1.0
                        }
                    }
            }
            .onAppear {
                // Delay for 2 seconds before transitioning
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
