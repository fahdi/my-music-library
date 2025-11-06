import Foundation
import AVFoundation
import Combine

class AudioPlayer: ObservableObject {
    @Published var currentTrack: Track?
    @Published var isPlaying = false
    @Published var currentTime: TimeInterval = 0
    @Published var duration: TimeInterval = 0
    @Published var volume: Float = 0.7

    private var player: AVPlayer?
    private var timeObserver: Any?
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Configure audio session for high-quality playback
        setupAudioSession()
    }

    private func setupAudioSession() {
        // macOS doesn't use AVAudioSession like iOS, but we can configure the player
        // to use the highest quality audio output
    }

    func play(track: Track) {
        // Stop current playback
        stop()

        // Create new player with high-quality settings
        let playerItem = AVPlayerItem(url: track.url)

        // Configure for highest quality audio
        playerItem.audioTimePitchAlgorithm = .varispeed
        playerItem.preferredForwardBufferDuration = 5

        player = AVPlayer(playerItem: playerItem)
        player?.volume = volume

        // Set audio output to highest quality
        if let player = player {
            // Enable automatic waiting to minimize stalls
            player.automaticallyWaitsToMinimizeStalling = true
        }

        currentTrack = track
        duration = track.duration

        // Add time observer
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTime = time.seconds
        }

        // Observe playback end
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: playerItem
        )

        player?.play()
        isPlaying = true
    }

    func togglePlayPause() {
        guard let player = player else { return }

        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }

    func stop() {
        player?.pause()
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }
        player = nil
        isPlaying = false
        currentTime = 0
        NotificationCenter.default.removeObserver(self)
    }

    func seek(to time: TimeInterval) {
        let cmTime = CMTime(seconds: time, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player?.seek(to: cmTime, toleranceBefore: .zero, toleranceAfter: .zero)
        currentTime = time
    }

    func setVolume(_ newVolume: Float) {
        volume = newVolume
        player?.volume = newVolume
    }

    @objc private func playerDidFinishPlaying() {
        isPlaying = false
        currentTime = 0
        // Could implement auto-play next track here
    }

    deinit {
        stop()
    }
}
