import SwiftUI

struct ContentView: View {
    @EnvironmentObject var musicLibrary: MusicLibrary
    @EnvironmentObject var audioPlayer: AudioPlayer
    @State private var selectedView = 0
    @State private var searchText = ""

    var body: some View {
        NavigationSplitView {
            // Sidebar
            VStack(alignment: .leading, spacing: 0) {
                // Library section
                VStack(alignment: .leading, spacing: 8) {
                    Label("Library", systemImage: "music.note.list")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, 20)

                    SidebarButton(
                        title: "Albums",
                        icon: "square.stack",
                        isSelected: selectedView == 0
                    ) {
                        selectedView = 0
                    }

                    SidebarButton(
                        title: "Tracks",
                        icon: "music.note",
                        isSelected: selectedView == 1
                    ) {
                        selectedView = 1
                    }
                }

                Spacer()

                // Open Folder button
                Button(action: {
                    musicLibrary.selectFolder()
                }) {
                    Label("Open Folder", systemImage: "folder")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.bordered)
                .padding()
            }
            .frame(width: 200)
            .background(Color(NSColor.controlBackgroundColor))
        } detail: {
            VStack(spacing: 0) {
                if musicLibrary.tracks.isEmpty {
                    EmptyLibraryView()
                } else {
                    // Main content area
                    if selectedView == 0 {
                        AlbumsView(searchText: searchText)
                    } else {
                        TracksView(searchText: searchText)
                    }
                }

                Divider()

                // Now Playing Bar
                NowPlayingBar()
                    .frame(height: 120)
                    .background(Color(NSColor.windowBackgroundColor))
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    if !musicLibrary.tracks.isEmpty {
                        TextField("Search", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 200)
                    }
                }
            }
        }
    }
}

struct SidebarButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label(title, systemImage: icon)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
                .cornerRadius(6)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 8)
    }
}

struct EmptyLibraryView: View {
    @EnvironmentObject var musicLibrary: MusicLibrary

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "music.note.house")
                .font(.system(size: 80))
                .foregroundColor(.secondary)

            Text("No Music Library")
                .font(.title)
                .fontWeight(.semibold)

            Text("Open a folder to get started")
                .foregroundColor(.secondary)

            Button("Open Folder") {
                musicLibrary.selectFolder()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
