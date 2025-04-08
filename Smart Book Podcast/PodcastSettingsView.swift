//
//  PodcastSettingsView.swift
//  Smart Book Podcast
//
//  Created by Andrii Halabuda on 4/7/25.
//

import SwiftUI

struct PodcastSettingsView: View {
    @Environment(\.dismiss) var dismiss

    @Binding var isGenerating: Bool
    @Binding var isPodcastReady: Bool

    @State private var selectedLength = "30 min"
    @State private var selectedSpeaker1 = "Jeremy (US English)"
    @State private var selectedSpeaker2 = "Kathy (US English)"
    @State private var selectedTone = "Neutral"
    @State private var isOfflineAvailable = true

    let lengths = ["5 min", "10 min", "15 min", "30 min", "45 min", "60 min"]
    let speakers1 = ["Emily (Australian English)", "Jeremy (US English)", "Tom (UK English)"]
    let speakers2 = ["Kathy (US English)", "Jeremy (US English)", "Tom (UK English)"]
    let tones = ["Casual", "Neutral", "Professional"]

    var body: some View {
        NavigationView {
            Form {
                // Info Card
                VStack(spacing: 12) {
                    Image("podcast")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 36)
                    Text("Book podcast")
                        .font(.title3)
                        .bold()
                    Text("Turn your book into a conversational podcast. Set your preferences and tap “Generate” — it’ll be ready in minutes.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)

                // Settings
                Section(
                    header: Text("Podcast Length"),
                    footer: Text("How much time do you have?")
                ) {
                    Picker("Maximum length", selection: $selectedLength) {
                        ForEach(lengths, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("SPEAKERS")) {
                    Picker("1st Host", selection: $selectedSpeaker1) {
                        ForEach(speakers1, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("2nd Host", selection: $selectedSpeaker2) {
                        ForEach(speakers2, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("SPEAKERS TONE")) {
                    Picker("Tone", selection: $selectedTone) {
                        ForEach(tones, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(
                    header: Text("OFFLINE AVAILABILITY"),
                    footer: Text("When ON, you can reach your podcast when offline")
                ) {
                    Toggle("Available Offline", isOn: $isOfflineAvailable)
                }
            }
            .navigationTitle("Podcast Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Generate") {
                        dismiss()
                        isGenerating.toggle()

                        // MARK: - Upload PDF file for processing

                        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
                            isGenerating = false
                            isPodcastReady = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var isGenerating = true
    @Previewable @State var isPodcastReady = true
    PodcastSettingsView(isGenerating: $isGenerating, isPodcastReady: $isPodcastReady)
}
