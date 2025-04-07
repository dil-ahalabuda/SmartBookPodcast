//
//  MainView.swift
//  Smart Book Podcast
//
//  Created by Andrii Halabuda on 4/7/25.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        TabView {

            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }

            Tab("Explore", systemImage: "newspaper.fill") {
                Text("Explore")
            }

            Tab("More", systemImage: "ellipsis") {
                Text("More")
            }

        }
    }
}

#Preview {
    MainView()
}
