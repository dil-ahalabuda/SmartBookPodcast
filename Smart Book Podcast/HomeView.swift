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
                CellView(imageName: "hand.raised", badgeCount: 6, label: "Approvals")
                CellView(imageName: "text.rectangle.page", badgeCount: 2, label: "Notes")
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
            }
            .padding()

            // List on the bottom
            List {
                ForEach(1..<6) { index in
                    Text("List Item \(index)")
                }
            }
        }
        .padding(.top)
        .background(Color(UIColor.background))
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

struct CellView: View {
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
    }
}

#Preview {
    HomeView()
}
