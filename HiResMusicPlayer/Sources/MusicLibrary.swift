import Foundation
import AppKit
import UniformTypeIdentifiers

class MusicLibrary: ObservableObject {
    @Published var tracks: [Track] = []
    @Published var albums: [Album] = []
    @Published var isLoading = false
    @Published var currentFolder: URL?

    private let supportedFormats = [
        "mp3", "m4a", "aac", "flac", "alac", "wav", "aiff", "aif",
        "dsd", "dsf", "dff", "ape", "wv", "tta", "opus"
    ]

    func selectFolder() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false
        panel.message = "Select a folder containing your music"

        panel.begin { [weak self] response in
            if response == .OK, let url = panel.url {
                self?.loadMusic(from: url)
            }
        }
    }

    func loadMusic(from url: URL) {
        currentFolder = url
        isLoading = true
        tracks = []
        albums = []

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }

            var foundTracks: [Track] = []

            // Recursively scan directory for audio files
            if let enumerator = FileManager.default.enumerator(
                at: url,
                includingPropertiesForKeys: [.isRegularFileKey],
                options: [.skipsHiddenFiles]
            ) {
                for case let fileURL as URL in enumerator {
                    // Check if it's a supported audio file
                    if self.supportedFormats.contains(fileURL.pathExtension.lowercased()) {
                        let track = Track(url: fileURL)
                        foundTracks.append(track)
                    }
                }
            }

            // Group tracks into albums
            let groupedTracks = Dictionary(grouping: foundTracks) { track in
                "\(track.album)|\(track.artist)"
            }

            var foundAlbums: [Album] = []
            for (_, albumTracks) in groupedTracks {
                if let firstTrack = albumTracks.first {
                    let album = Album(
                        name: firstTrack.album,
                        artist: firstTrack.artist,
                        tracks: albumTracks.sorted { $0.title < $1.title },
                        albumArt: firstTrack.albumArt
                    )
                    foundAlbums.append(album)
                }
            }

            DispatchQueue.main.async {
                self.tracks = foundTracks.sorted { $0.title < $1.title }
                self.albums = foundAlbums.sorted { $0.name < $1.name }
                self.isLoading = false
            }
        }
    }

    func searchTracks(query: String) -> [Track] {
        if query.isEmpty {
            return tracks
        }

        return tracks.filter { track in
            track.title.localizedCaseInsensitiveContains(query) ||
            track.artist.localizedCaseInsensitiveContains(query) ||
            track.album.localizedCaseInsensitiveContains(query)
        }
    }

    func searchAlbums(query: String) -> [Album] {
        if query.isEmpty {
            return albums
        }

        return albums.filter { album in
            album.name.localizedCaseInsensitiveContains(query) ||
            album.artist.localizedCaseInsensitiveContains(query)
        }
    }
}
