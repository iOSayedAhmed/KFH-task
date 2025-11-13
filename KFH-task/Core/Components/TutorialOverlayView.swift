//
//  TutorialOverlayView.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import SwiftUI

struct TutorialOverlayView: View {
    @Binding var isVisible: Bool
    let autoHideDuration: TimeInterval = 2.0

    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            // Tutorial content
            VStack(spacing: 24) {
                // Welcome icon
                Image(systemName: "hand.wave.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.yellow)

                // Welcome text
                VStack(spacing: 16) {
                    Text("Welcome to KFH Task! 👋")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Browse GitHub repositories with search and filtering capabilities. Tap the info button to learn about the developer!")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                }

                // Features overview
                VStack(alignment: .leading, spacing: 12) {
                    FeatureRow(icon: "magnifyingglass", text: "Search repositories by name")
                    FeatureRow(icon: "arrow.clockwise", text: "Pull to refresh data")
                    FeatureRow(icon: "info.circle", text: "Tap info button for developer CV")
                }
                .padding(.horizontal)

                // Auto-hide indicator
                HStack {
                    Image(systemName: "clock")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                    Text("This tutorial will close automatically")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top, 8)
            }
            .padding(32)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .padding(.horizontal, 24)
        }
        .opacity(isVisible ? 1 : 0)
        .scaleEffect(isVisible ? 1 : 0.8)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isVisible)
        .onAppear {
            if isVisible {
                startAutoHideTimer()
            }
        }
    }

    private func startAutoHideTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + autoHideDuration) {
            withAnimation {
                isVisible = false
            }
            // Mark tutorial as shown after hiding
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UserDefaults.standard.markTutorialAsShown()
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.blue)
                .frame(width: 20)

            Text(text)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))

            Spacer()
        }
    }
}

