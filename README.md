# HiRes Music Player for macOS

A beautiful, native macOS application for playing high-resolution audio files with a focus on usability and stunning album art display.

## Features

- **High-Resolution Audio Support**: Play lossless audio formats including FLAC, ALAC, WAV, AIFF, and more
- **Beautiful Album Art Display**: Large, prominent album artwork similar to physical audio devices
- **Easy Library Management**: Load music from any folder on your computer
- **Quality Indicators**: See bit depth and sample rate for each track
- **Intuitive Interface**: Clean, modern SwiftUI interface designed for music lovers
- **Album and Track Views**: Browse your music by albums or individual tracks
- **Search Functionality**: Quickly find tracks, albums, or artists
- **Playback Controls**: Standard play/pause, seek, and volume controls

## Supported Audio Formats

- MP3
- M4A/AAC
- FLAC (Free Lossless Audio Codec)
- ALAC (Apple Lossless)
- WAV
- AIFF/AIF
- DSF/DFF (DSD formats)
- APE (Monkey's Audio)
- WV (WavPack)
- TTA (True Audio)
- Opus

## Requirements

- macOS 13.0 (Ventura) or later
- Xcode 15.0 or later

## Building the App

### Method 1: Using Xcode GUI (Recommended)

1. Open Xcode
2. Select "File" > "New" > "Project"
3. Choose "macOS" > "App"
4. Fill in the project details:
   - Product Name: `HiResMusicPlayer`
   - Team: Select your development team
   - Organization Identifier: Your identifier (e.g., `com.yourname`)
   - Interface: SwiftUI
   - Language: Swift
   - Minimum macOS version: 13.0
5. Save the project to this directory
6. In the Project Navigator, delete the default `ContentView.swift` and `HiResMusicPlayerApp.swift` files
7. Drag all `.swift` files from the `HiResMusicPlayer/Sources` folder into your project
8. Add the `Info.plist` from `HiResMusicPlayer/Resources` to your project
9. Build and run (Cmd+R)

### Method 2: Using Command Line with xcodebuild

If you have an `.xcodeproj` file set up:

```bash
cd HiResMusicPlayer
xcodebuild -scheme HiResMusicPlayer -configuration Release build
```

## Project Structure

```
HiResMusicPlayer/
├── Sources/
│   ├── HiResMusicPlayerApp.swift    # Main app entry point
│   ├── Models.swift                  # Data models for Track and Album
│   ├── AudioPlayer.swift             # Core audio playback engine
│   ├── MusicLibrary.swift            # Library management and file loading
│   ├── ContentView.swift             # Main app view and layout
│   ├── AlbumsView.swift              # Album grid view
│   ├── TracksView.swift              # Track list view
│   └── NowPlayingBar.swift           # Playback controls and now playing
└── Resources/
    └── Info.plist                    # App configuration
```

## Usage

1. Launch the app
2. Click "Open Folder" or use Cmd+O to select a folder containing your music
3. The app will scan the folder and all subfolders for supported audio files
4. Browse your music by Albums or Tracks using the sidebar
5. Click on an album or track to start playing
6. Enjoy beautiful album art and high-quality audio playback!

## Architecture

### Audio Engine

The app uses AVFoundation's `AVPlayer` for audio playback, which provides:
- Native support for all macOS-supported audio formats
- High-quality audio output
- Precise seeking and time control
- Volume control

### UI Components

Built with SwiftUI for a modern, native macOS experience:
- **ContentView**: Main layout with navigation and content areas
- **AlbumsView**: Grid of album cards with hover effects
- **TracksView**: Detailed track list with metadata
- **NowPlayingBar**: Playback controls with prominent album art

### Data Management

- **MusicLibrary**: Manages file system scanning and organization
- **AudioPlayer**: Handles playback state and control
- **Models**: Track and Album data structures with metadata extraction

## Technical Details

### Metadata Extraction

The app automatically extracts metadata from audio files including:
- Track title, artist, album
- Album artwork
- Duration
- Bit depth and sample rate (for quality display)

### Performance

- Asynchronous file scanning to keep UI responsive
- Lazy loading for large libraries
- Efficient image handling for album artwork

## Future Enhancements

Potential features for future versions:
- Playlist support
- Queue management
- Keyboard shortcuts
- Mini player mode
- Equalizer
- Gapless playback
- Integration with Last.fm or similar services
- Dark/Light mode customization

## License

This is a personal project. Feel free to modify and use as needed.

## Troubleshooting

### Audio files not loading
- Ensure the files are in a supported format
- Check file permissions
- Try selecting a different folder

### No album art showing
- Album art must be embedded in the audio file
- Supported formats: JPEG, PNG embedded in metadata

### Playback issues
- Check system audio output settings
- Ensure no other apps are monopolizing audio
- Try restarting the app

## Credits

Built with Swift, SwiftUI, and AVFoundation for macOS.
