//
//  PlayerView.swift
//  Smart Book Podcast
//
//  Created by Andrii Halabuda on 4/7/25.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var currentTime: Double = 0
    @State private var duration: Double = 1

    @Environment(\.dismiss) var dismiss

    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 24) {
            // Top bar
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .foregroundColor(.primary)
                }

                Spacer()

                Text("Now Playing")
                    .font(.headline)
                    .foregroundColor(.blue)

                Spacer()
            }
            .padding(.horizontal)

            // Cover Art
            Image(systemName: "mic.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.top, 20)
                .foregroundStyle(.blue)

            // Title & Subtitle
            VStack(spacing: 4) {
                Text("Financial Review & Planning 2025 Q1")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)

                Text("31 Mach, 2025")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            // Progress Slider
            VStack(spacing: 8) {
                Slider(value: $currentTime, in: 0...duration, onEditingChanged: sliderEditingChanged)
                    .accentColor(.blue)

                HStack {
                    Text(formatTime(currentTime))
                        .font(.caption)
                        .foregroundColor(.gray)

                    Spacer()

                    Text(formatTime(duration))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 4)
            }
            .padding(.horizontal)

            // Playback Controls
            HStack(spacing: 40) {
                Button(action: rewind15) {
                    Image(systemName: "gobackward.15")
                        .font(.title)
                }

                Button(action: togglePlayback) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.blue)
                }

                Button(action: forward15) {
                    Image(systemName: "goforward.15")
                        .font(.title)
                }
            }
            .padding(.top, 16)

            Spacer()
        }
        .padding()
        .onAppear {
            loadAudio()
        }
        .onReceive(timer) { _ in
            guard let player = audioPlayer, player.isPlaying else { return }
            currentTime = player.currentTime
        }
        .background(Color(.background))
        .edgesIgnoringSafeArea(.bottom)
    }

    func loadAudio() {
        guard let remoteURL = URL(string: "https://thepodcastexchange.ca/s/Porsche-Macan-July-5-2018-1.mp3") else {
            print("Invalid URL.")
            return
        }

        // Download the file
        URLSession.shared.downloadTask(with: remoteURL) { tempURL, response, error in
            if let error = error {
                print("Download error: \(error)")
                return
            }

            guard let tempURL = tempURL else {
                print("No file URL.")
                return
            }

            do {
                // Move to a persistent location (optional)
                let fileManager = FileManager.default
                let caches = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
                let localURL = caches.appendingPathComponent("downloaded.mp3")

                if fileManager.fileExists(atPath: localURL.path) {
                    try fileManager.removeItem(at: localURL)
                }
                try fileManager.copyItem(at: tempURL, to: localURL)

                // Create player
                audioPlayer = try AVAudioPlayer(contentsOf: localURL)
                audioPlayer?.prepareToPlay()

                DispatchQueue.main.async {
                    duration = audioPlayer?.duration ?? 1
                }

            } catch {
                print("Failed to prepare audio: \(error)")
            }

        }.resume()
    }

    func togglePlayback() {
        guard let player = audioPlayer else { return }
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }

    func sliderEditingChanged(_ editing: Bool) {
        if !editing {
            audioPlayer?.currentTime = currentTime
        }
    }

    func rewind15() {
        guard let player = audioPlayer else { return }
        player.currentTime = max(0, player.currentTime - 15)
    }

    func forward15() {
        guard let player = audioPlayer else { return }
        player.currentTime = min(duration, player.currentTime + 15)
    }

    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

#Preview {
    PlayerView()
}
