//
//  ContentView.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//  KFH-task

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var diContainer: DIContainer

    // Tutorial and PDF states
    @State private var showTutorial = false
    @State private var showPDF = false

    var body: some View {
        ZStack {
            // Main content with repositories
            GitHubRepositoriesView()
            // Tutorial overlay
            if showTutorial {
                TutorialOverlayView(isVisible: $showTutorial)
            }
        }
        .sheet(isPresented: $showPDF) {
            PDFViewerView(pdfName: "Elsayed-Ahmed-iOS-CV")
        }
        .onAppear {
            handleAppLaunch()
        }
    }

    private func handleAppLaunch() {
        // Increment launch count
        UserDefaults.standard.incrementLaunchCount()

        // Show tutorial if this is the first launch
        if UserDefaults.standard.shouldShowTutorial() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    showTutorial = true
                }
            }
        }

        // Log app configuration
        if AppConfiguration.App.isDebugMode {
            print("App launched - Count: \(UserDefaults.standard.appLaunchCount)")
            print("Configuration: \(ConfigurationManager.shared.appName)")
            print("API Base URL: \(ConfigurationManager.shared.apiBaseURL)")
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .environmentObject(DIContainer.shared)
}
