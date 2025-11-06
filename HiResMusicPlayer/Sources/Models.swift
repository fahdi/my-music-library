import Foundation
import AVFoundation
import AppKit

struct Track: Identifiable, Hashable {
    let id = UUID()
    let url: URL
    var title: String
    var artist: String
    var album: String
    var duration: TimeInterval
    var albumArt: NSImage?
    var bitDepth: String?
    var sampleRate: String?

    init(url: URL) {
        self.url = url

        // Extract metadata
        let asset = AVAsset(url: url)
        var title = url.deletingPathExtension().lastPathComponent
        var artist = "Unknown Artist"
        var album = "Unknown Album"
        var duration: TimeInterval = 0
        var albumArt: NSImage?
        var bitDepth: String?
        var sampleRate: String?

        // Get duration
        duration = asset.duration.seconds

        // Extract metadata from asset
        let metadata = asset.metadata
        for item in metadata {
            guard let commonKey = item.commonKey,
                  let value = item.value else { continue }

            switch commonKey {
            case .commonKeyTitle:
                if let titleValue = value as? String {
                    title = titleValue
                }
            case .commonKeyArtist:
                if let artistValue = value as? String {
                    artist = artistValue
                }
            case .commonKeyAlbumName:
                if let albumValue = value as? String {
                    album = albumValue
                }
            case .commonKeyArtwork:
                if let imageData = value as? Data {
                    albumArt = NSImage(data: imageData)
                }
            default:
                break
            }
        }

        // Try to get audio format info (synchronous API)
        #if compiler(>=5.5)
        if #available(macOS 12.0, *) {
            let tracks = asset.tracks(withMediaType: .audio)
            if let firstTrack = tracks.first {
                let formatDescriptions = firstTrack.formatDescriptions
                for description in formatDescriptions {
                    if let audioDesc = CMAudioFormatDescriptionGetStreamBasicDescription(description as! CMAudioFormatDescription) {
                        let sr = audioDesc.pointee.mSampleRate
                        sampleRate = "\(Int(sr / 1000)) kHz"

                        let bd = audioDesc.pointee.mBitsPerChannel
                        if bd > 0 {
                            bitDepth = "\(bd)-bit"
                        }
                    }
                }
            }
        }
        #endif

        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.albumArt = albumArt
        self.bitDepth = bitDepth
        self.sampleRate = sampleRate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Track, rhs: Track) -> Bool {
        lhs.id == rhs.id
    }
}

struct Album: Identifiable {
    let id = UUID()
    let name: String
    let artist: String
    var tracks: [Track]
    var albumArt: NSImage?

    var duration: TimeInterval {
        tracks.reduce(0) { $0 + $1.duration }
    }
}
