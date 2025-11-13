//
//  TooltipView.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import SwiftUI

struct TooltipView: View {
    let text: String
    let isVisible: Bool

    var body: some View {
        VStack {
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.black.opacity(0.8))
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                        )
                )
                .scaleEffect(isVisible ? 1 : 0.8)
                .opacity(isVisible ? 1 : 0)
                .animation(.easeInOut(duration: 0.2), value: isVisible)

            // Tooltip arrow
            Triangle()
                .fill(Color.black.opacity(0.8))
                .frame(width: 12, height: 6)
                .scaleEffect(isVisible ? 1 : 0.8)
                .opacity(isVisible ? 1 : 0)
                .animation(.easeInOut(duration: 0.2), value: isVisible)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

struct TooltipModifier: ViewModifier {
    let text: String
    @State private var isVisible = false

    func body(content: Content) -> some View {
        VStack {
            TooltipView(text: text, isVisible: isVisible)

            content
                .onLongPressGesture(minimumDuration: 0.5) {
                    showTooltip()
                }
        }
    }

    private func showTooltip() {
        withAnimation {
            isVisible = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                isVisible = false
            }
        }
    }
}

extension View {
    func tooltip(_ text: String) -> some View {
        modifier(TooltipModifier(text: text))
    }
}

#Preview {
    VStack(spacing: 50) {
        Button("Long press me") {
            // Action
        }
        .tooltip("This is a helpful tooltip!")
        .buttonStyle(.borderedProminent)

        TooltipView(text: "Sample Tooltip", isVisible: true)
    }
    .padding()
}
