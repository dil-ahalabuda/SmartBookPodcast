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
                Text("Board Meeting Q1")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)

                Text("24 September, 2024")
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
        guard let url = Bundle.main.url(forResource: "sample", withExtension: "mp3") else {
            print("MP3 file not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            duration = audioPlayer?.duration ?? 1
        } catch {
            print("Failed to load audio: \(error)")
        }
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
