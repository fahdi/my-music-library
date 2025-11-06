import SwiftUI

struct AlbumsView: View {
    @EnvironmentObject var musicLibrary: MusicLibrary
    @EnvironmentObject var audioPlayer: AudioPlayer
    let searchText: String

    private let columns = [
        GridItem(.adaptive(minimum: 180, maximum: 200), spacing: 20)
    ]

    var filteredAlbums: [Album] {
        musicLibrary.searchAlbums(query: searchText)
    }

    var body: some View {
        ScrollView {
            if musicLibrary.isLoading {
                ProgressView("Loading music library...")
                    .padding()
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(filteredAlbums) { album in
                        AlbumCard(album: album)
                    }
                }
                .padding()
            }
        }
    }
}

struct AlbumCard: View {
    @EnvironmentObject var audioPlayer: AudioPlayer
    let album: Album
    @State private var isHovered = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Album artwork
            ZStack {
                if let albumArt = album.albumArt {
                    Image(nsImage: albumArt)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 180, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.secondary.opacity(0.2))
                        .frame(width: 180, height: 180)
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.system(size: 50))
                                .foregroundColor(.secondary)
                        )
                }

                // Play button overlay on hover
                if isHovered {
                    Color.black.opacity(0.4)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    Button(action: {
                        if let firstTrack = album.tracks.first {
                            audioPlayer.play(track: firstTrack)
                        }
                    }) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.accentColor))
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(width: 180, height: 180)
            .onHover { hovering in
                withAnimation(.easeInOut(duration: 0.15)) {
                    isHovered = hovering
                }
            }

            // Album info
            VStack(alignment: .leading, spacing: 4) {
                Text(album.name)
                    .font(.headline)
                    .lineLimit(1)

                Text(album.artist)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)

                Text("\(album.tracks.count) tracks")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(width: 180, alignment: .leading)
        }
    }
}
