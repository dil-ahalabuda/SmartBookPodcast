//
//  HomeView.swift
//  Smart Book Podcast
//
//  Created by Andrii Halabuda on 4/7/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Home")
                    .font(.title)
                    .fontWeight(.semibold)

                Spacer()

                HStack(spacing: 8) {
                    Button {
                        // Action
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.black)
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                    .frame(width: 48, height: 48)

                    Button {
                        // Action
                    } label: {
                        Image(systemName: "bell.badge")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.black)
                            .frame(width: 24, height: 24)
                            .padding()
                    }
                    .frame(width: 48, height: 48)

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
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.2))
                    .frame(height: 100)
                    .overlay(Text("Cell 1"))

                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green.opacity(0.2))
                    .frame(height: 100)
                    .overlay(Text("Cell 2"))
            }
            .padding(.horizontal)

            // List on the bottom
            List {
                ForEach(1..<6) { index in
                    Text("List Item \(index)")
                }
            }
        }
        .padding(.top)
    }
}

#Preview {
    HomeView()
}
