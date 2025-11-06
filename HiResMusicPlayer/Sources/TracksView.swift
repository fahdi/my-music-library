import SwiftUI

struct TracksView: View {
    @EnvironmentObject var musicLibrary: MusicLibrary
    @EnvironmentObject var audioPlayer: AudioPlayer
    let searchText: String

    var filteredTracks: [Track] {
        musicLibrary.searchTracks(query: searchText)
    }

    var body: some View {
        VStack(spacing: 0) {
            if musicLibrary.isLoading {
                ProgressView("Loading music library...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Table header
                HStack(spacing: 12) {
                    Text("")
                        .frame(width: 40)

                    Text("Title")
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Artist")
                        .frame(width: 200, alignment: .leading)

                    Text("Album")
                        .frame(width: 200, alignment: .leading)

                    Text("Quality")
                        .frame(width: 100, alignment: .leading)

                    Text("Duration")
                        .frame(width: 80, alignment: .trailing)
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(NSColor.controlBackgroundColor))

                Divider()

                // Tracks list
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredTracks) { track in
                            TrackRow(track: track)
                        }
                    }
                }
            }
        }
    }
}

struct TrackRow: View {
    @EnvironmentObject var audioPlayer: AudioPlayer
    let track: Track
    @State private var isHovered = false

    var isCurrentTrack: Bool {
        audioPlayer.currentTrack?.id == track.id
    }

    var body: some View {
        Button(action: {
            audioPlayer.play(track: track)
        }) {
            HStack(spacing: 12) {
                // Album art thumbnail
                if let albumArt = track.albumArt {
                    Image(nsImage: albumArt)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.secondary.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        )
                }

                // Track info
                Text(track.title)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(isCurrentTrack ? .accentColor : .primary)
                    .fontWeight(isCurrentTrack ? .semibold : .regular)

                Text(track.artist)
                    .lineLimit(1)
                    .frame(width: 200, alignment: .leading)
                    .foregroundColor(.secondary)

                Text(track.album)
                    .lineLimit(1)
                    .frame(width: 200, alignment: .leading)
                    .foregroundColor(.secondary)

                // Quality info
                HStack(spacing: 4) {
                    if let bitDepth = track.bitDepth {
                        Text(bitDepth)
                            .font(.caption2)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(Color.accentColor.opacity(0.2))
                            .cornerRadius(4)
                    }
                    if let sampleRate = track.sampleRate {
                        Text(sampleRate)
                            .font(.caption2)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(Color.accentColor.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
                .frame(width: 100, alignment: .leading)

                Text(formatDuration(track.duration))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 80, alignment: .trailing)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(isHovered ? Color.accentColor.opacity(0.1) : Color.clear)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
        }
    }

    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
