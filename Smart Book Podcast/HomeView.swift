//
//  HomeView.swift
//  Smart Book Podcast
//
//  Created by Andrii Halabuda on 4/7/25.
//

import SwiftUI

struct HomeView: View {

    @State private var showSettings = false
    @State private var showPlayer = false
    @State private var isGenerating = false
    @State private var isPodcastReady = false

    private var bookCellViewModels: [BookCellViewModel] = [
        BookCellViewModel(title: "Financial Review & Planning 2025 Q1", date: "31 Mach, 2025", subtitle: "Board of Director, ESG Committee"),
        BookCellViewModel(title: "ESG Committee Meeting Q1", date: "28 Mach, 2025", subtitle: "Board of Director, ESG Committee"),
        BookCellViewModel(title: "ESG & Sustainability Forecast Review Meeting", date: "20 Mach, 2025", subtitle: "Board of Director, ESG Committee"),
        BookCellViewModel(title: "Financial Review & Planning 2025 Q2", date: "21 Mach, 2025", subtitle: "ESG Committee"),
        BookCellViewModel(title: "Boards Planning 2025 Q2", date: "18 Mach, 2025", subtitle: "Board of Director, ESG Committee"),
    ]

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Home")
                    .font(.title)
                    .fontWeight(.semibold)

                Spacer()

                HStack(spacing: 8) {
                    IconButton(systemName: "magnifyingglass")
                    IconButton(systemName: "bell.badge")

                    Button {
                        // Action
                    } label: {
                        Text("AB")
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    .frame(width: 48, height: 48)
                    .background(Color.profile)
                    .clipShape(Circle())
                }
            }
            .padding(.horizontal)

            // Two horizontal cells
            HStack(spacing: 16) {
                CardView(imageName: "hand.raised", badgeCount: 6, label: "Approvals")
                CardView(imageName: "text.rectangle.page", badgeCount: 2, label: "Notes")
            }
            .padding(.horizontal)

            HStack {
                Text("Books")
                    .font(.title3)
                    .fontWeight(.semibold)

                Spacer()

                Button {
                    // Action
                } label: {
                    Text("Upcoming meetings")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding()
                }
                .frame(width: 180, height: 40)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            }
            .padding()

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(0..<5) { index in
                        BookCellView(
                            viewModel: bookCellViewModels[index],
                            showSettings: $showSettings,
                            showPlayer: $showPlayer,
                            isGenerating: $isGenerating,
                            isPodcastReady: $isPodcastReady
                        )
                    }
                }
            }
        }
        .padding(.top)
        .background(Color(UIColor.background))
        .sheet(isPresented: $showSettings) {
            PodcastSettingsView(isGenerating: $isGenerating, isPodcastReady: $isPodcastReady)
        }
        .sheet(isPresented: $showPlayer) {
            PlayerView()
        }
    }
}

struct BookCellViewModel {
    let title: String
    let date: String
    let subtitle: String
}

struct BookCellView: View {
    let viewModel: BookCellViewModel

    @State private var animate = false

    @Binding var showSettings: Bool
    @Binding var showPlayer: Bool
    @Binding var isGenerating: Bool
    @Binding var isPodcastReady: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.title)
                        .font(.headline)
                    Text(viewModel.date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(viewModel.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                Menu {
                    Button("Open agenda") { }
                    Button("See meeting details") { }
                    Button("See book updates") { }
                    Button("Generate book podcast") {
                        showSettings.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .padding(8)
                        .foregroundStyle(Color(UIColor.action))
                }
                .padding(.trailing, 8)
            }

            HStack {
                HStack(spacing: 8) {
                    TagButton(text: "New")
                    TagButton(text: "Approvals")
                }

                Spacer()

                if isGenerating && viewModel.title == "Financial Review & Planning 2025 Q1" {
                    HStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        Text("Generating podcast")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                } else if isPodcastReady && viewModel.title == "Financial Review & Planning 2025 Q1" {
                    Button {
                        showPlayer.toggle()
                    } label: {
                        Image(systemName: "headphones")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.blue)
                            .frame(width: 18, height: 18)
                            .padding()
                            .scaleEffect(animate ? 1.0 : 0.5)
                            .onAppear {
                                withAnimation(.interpolatingSpring(stiffness: 50, damping: 5).delay(0.1)) {
                                    animate = true
                                }
                            }
                    }
                    .frame(width: 48, height: 32)
                    .background(Color.blue.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }

            }
        }
        .padding()
        .background(Color(.systemBackground))
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Tag Button
struct TagButton: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.1))
            .foregroundColor(.black)
            .clipShape(Capsule())
    }
}

struct IconButton: View {
    let systemName: String

    var body: some View {
        Button {
            // Action
        } label: {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.black)
                .frame(width: 24, height: 24)
                .padding()
        }
        .frame(width: 48, height: 48)
    }
}

struct CardView: View {
    let imageName: String
    let badgeCount: Int
    let label: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)

            VStack {
                HStack {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color(UIColor.action))
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)
                        .padding(.top, 8)

                    Spacer()

                    if badgeCount > 0 {
                        Text("\(badgeCount)")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.red)
                            .clipShape(Circle())
                            .padding(.trailing, 16)
                            .padding(.top, 8)
                    }
                }

                Spacer()

                HStack {
                    Text(label)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .padding([.leading, .bottom], 16)

                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 82)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
}
