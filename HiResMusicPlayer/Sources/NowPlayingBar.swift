import SwiftUI

struct NowPlayingBar: View {
    @EnvironmentObject var audioPlayer: AudioPlayer
    @State private var isDraggingSlider = false
    @State private var sliderValue: Double = 0

    var body: some View {
        HStack(spacing: 16) {
            // Album art
            if let track = audioPlayer.currentTrack {
                if let albumArt = track.albumArt {
                    Image(nsImage: albumArt)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 4)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.secondary.opacity(0.2))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Image(systemName: "music.note")
                                .font(.system(size: 40))
                                .foregroundColor(.secondary)
                        )
                }

                // Track info and controls
                VStack(alignment: .leading, spacing: 8) {
                    // Track title and artist
                    VStack(alignment: .leading, spacing: 2) {
                        Text(track.title)
                            .font(.headline)
                            .lineLimit(1)

                        HStack(spacing: 8) {
                            Text(track.artist)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(1)

                            // Quality badges
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
                    }

                    // Playback controls
                    HStack(spacing: 20) {
                        // Play/Pause button
                        Button(action: {
                            audioPlayer.togglePlayPause()
                        }) {
                            Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 24))
                                .frame(width: 40, height: 40)
                        }
                        .buttonStyle(.plain)

                        // Progress bar
                        VStack(spacing: 4) {
                            Slider(
                                value: isDraggingSlider ? $sliderValue : Binding(
                                    get: { audioPlayer.currentTime },
                                    set: { _ in }
                                ),
                                in: 0...max(audioPlayer.duration, 1),
                                onEditingChanged: { editing in
                                    isDraggingSlider = editing
                                    if !editing {
                                        audioPlayer.seek(to: sliderValue)
                                    } else {
                                        sliderValue = audioPlayer.currentTime
                                    }
                                }
                            )
                            .frame(width: 300)

                            HStack {
                                Text(formatTime(audioPlayer.currentTime))
                                    .font(.caption)
                                    .foregroundColor(.secondary)

                                Spacer()

                                Text(formatTime(audioPlayer.duration))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 300)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Volume control
                HStack(spacing: 8) {
                    Image(systemName: "speaker.fill")
                        .foregroundColor(.secondary)

                    Slider(
                        value: Binding(
                            get: { audioPlayer.volume },
                            set: { audioPlayer.setVolume(Float($0)) }
                        ),
                        in: 0...1
                    )
                    .frame(width: 100)

                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundColor(.secondary)
                }
                .padding(.trailing)
            } else {
                // No track playing
                HStack {
                    Image(systemName: "music.note")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)

                    Text("No track playing")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding()
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
