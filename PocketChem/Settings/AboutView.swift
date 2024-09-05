//
//  AboutView.swift
//  PocketChem
//
//  Created by Ajay Gandecha on 9/3/24.
//

import Data
import Design
import Tools
import SwiftUI

struct AboutView: View {

    /// Environment variable that provides a function
    /// to open URLs in the device browser.
    @Environment(\.openURL) var openURL

    var body: some View {
        NavigationStack {
            List {
                developerSection
                aboutSection
                acknowledgementsSection
            }
            .navigationTitle("About PocketChem")
        }
    }

    @ViewBuilder
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 6.0) {
                Text("Ajay Gandecha")
                    .font(.headline)
                    .foregroundColor(.secondary)

                NavigationLink {
                    EmptyView()
                } label: {
                    Button {
                        if let url = URL(string: "https://ajaygandecha.com") {
                            openURL(url)
                        }
                    } label: {
                        Text("""
                        Hello friends, my name is Ajay! I am an iOS Developer and student at UNC-Chapel Hill \
                        studying Computer Science and Data Science.
                        """)
                    }
                    .buttonStyle(.plain)
                }
            }
        } header: {
            Label("About The Developer", systemImage: "hand.wave")
        }
    }

    @ViewBuilder
    private var aboutSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 16.0) {
                Text("""
                Fresh after taking my high school chemistry class, I realized how basic chemistry information is \
                scattered across many independent resources, and I wanted to create an app that combined all of this \
                information in an accessible, easy-to-use tool. I first released PocketChem in January 2020 when I \
                was a sophomore in high school.
                """)

                Text("PocketChem was revamped in 2024 using the latest iOS development best-practices and features.")

            }
        } header: {
            Label("About PocketChem", systemImage: "flask")
        }
    }

    @ViewBuilder
    private var acknowledgementsSection: some View {
        Section {
            Text("PocketChem is powered by data from select external sources.")

            Button {
                openURL(URL(string: "https://periodic.lanl.gov/index.shtml")!)
            } label: {
                NavigationLink {
                    EmptyView()
                } label: {
                    VStack(alignment: .leading, spacing: 6.0) {
                        Text("Los Alamos National Public Library")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        Text("""
                        Elements' history and uses data comes directly from the free Los Alamos National Library \
                        public resource.
                        """)

                        Text("""
                         For Scientific and Technical Information Only: © Copyright Triad National Security, \
                         LLC. All Rights Reserved.
                        """)
                            .foregroundStyle(.secondary)
                    }
                }

            }
            .buttonStyle(.plain)

        } header: {
            Label("Acknowledgements", systemImage: "text.quote")
        }
    }
}

#Preview {
    AboutView()
}
