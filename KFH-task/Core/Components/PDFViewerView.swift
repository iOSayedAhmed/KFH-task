//
//  PDFViewerView.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import SwiftUI
import PDFKit

struct PDFViewerView: View {
    let pdfName: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            Group {
                if let pdfDocument = loadPDF() {
                    PDFViewRepresentable(pdfDocument: pdfDocument)
                } else {
                    PDFErrorView()
                }
            }
            .navigationTitle("Developer CV")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .font(.body)
                    .foregroundColor(.blue)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    ShareButton(pdfName: pdfName)
                }
            }
        }
    }

    private func loadPDF() -> PDFDocument? {
        guard let path = Bundle.main.path(forResource: pdfName, ofType: "pdf"),
              let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) else {
            print("❌ Could not load PDF: \(pdfName).pdf")
            return nil
        }
        print("✅ Successfully loaded PDF: \(pdfName).pdf")
        return pdfDocument
    }
}

struct PDFViewRepresentable: UIViewRepresentable {
    let pdfDocument: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.backgroundColor = UIColor.systemBackground
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // No updates needed
    }
}

struct PDFErrorView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "doc.text.fill")
                .font(.system(size: 60))
                .foregroundColor(.red.opacity(0.7))

            VStack(spacing: 8) {
                Text("PDF Not Available")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text("The CV file could not be loaded. Please check if the PDF file is included in the app bundle.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }

            Button("Retry") {
                // Trigger a refresh by dismissing and reopening
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 32)
    }
}

struct ShareButton: View {
    let pdfName: String

    var body: some View {
        Button(action: sharePDF) {
            Image(systemName: "square.and.arrow.up")
                .font(.body)
        }
    }

    private func sharePDF() {
        guard let path = Bundle.main.path(forResource: pdfName, ofType: "pdf"),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            print("❌ Could not share PDF")
            return
        }

        let url = URL(fileURLWithPath: path)
        let activityViewController = UIActivityViewController(
            activityItems: [url],
            applicationActivities: nil
        )

        // For iPad
        if let popover = activityViewController.popoverPresentationController {
            popover.sourceView = window
            popover.sourceRect = CGRect(x: window.bounds.midX, y: window.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }

        window.rootViewController?.present(activityViewController, animated: true)
    }
}

#Preview {
    PDFViewerView(pdfName: "Elsayed-Ahmed-iOS-CV")
}
