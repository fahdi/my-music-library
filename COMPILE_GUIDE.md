# Quick Compilation Guide

## Prerequisites
- macOS 13.0 (Ventura) or later
- Xcode 15.0 or later (download from Mac App Store)

## Step-by-Step Compilation

### 1. Install Xcode
```bash
# Open Mac App Store and search for "Xcode"
# Or use command line:
xcode-select --install
```

### 2. Create the Xcode Project

**Option A: Using Xcode GUI (Recommended)**

1. Open Xcode
2. File → New → Project
3. Select: macOS → App
4. Configure:
   - Product Name: `HiResMusicPlayer`
   - Interface: SwiftUI
   - Language: Swift
   - Minimum macOS: 13.0
5. Save to the `my-music-library` folder
6. **Uncheck** "Create Git repository" (we already have one)

### 3. Add Source Files

1. Delete default files:
   - `HiResMusicPlayerApp.swift` (Xcode's default)
   - `ContentView.swift` (Xcode's default)

2. Drag all `.swift` files from `HiResMusicPlayer/Sources/` into Xcode:
   - In the dialog, check ✅ "Copy items if needed"
   - Check ✅ your app target

Files to add:
```
HiResMusicPlayer/Sources/
├── HiResMusicPlayerApp.swift
├── Models.swift
├── AudioPlayer.swift
├── MusicLibrary.swift
├── ContentView.swift
├── AlbumsView.swift
├── TracksView.swift
└── NowPlayingBar.swift
```

### 4. Configure Build Settings

1. Click project name in Project Navigator
2. Select your app under TARGETS
3. General tab:
   - Minimum Deployment: macOS 13.0
   - Bundle Identifier: com.yourname.HiResMusicPlayer

### 5. Compile and Run

**Using Xcode:**
```
Press: Cmd + R (or click the ▶️ Run button)
```

**Build only (no run):**
```
Press: Cmd + B
```

The app will compile and launch automatically!

---

## Option B: Command Line Compilation

If you prefer command line (after creating the Xcode project):

```bash
# Navigate to the project directory
cd /path/to/my-music-library/HiResMusicPlayer

# Build for Debug (faster compilation)
xcodebuild -scheme HiResMusicPlayer -configuration Debug

# Build for Release (optimized)
xcodebuild -scheme HiResMusicPlayer -configuration Release

# Run the app after building
open build/Release/HiResMusicPlayer.app
```

---

## Option C: Using Swift Package Manager (Advanced)

You can also create a Swift package, but SwiftUI macOS apps work best with Xcode projects.

To create a Package.swift:

```bash
cd HiResMusicPlayer
swift package init --type executable
```

However, this approach has limitations for macOS apps with UI.

---

## Troubleshooting

### "Command not found: xcodebuild"
```bash
# Install Xcode Command Line Tools
xcode-select --install

# Set Xcode path
sudo xcode-select --switch /Applications/Xcode.app
```

### "No such module 'SwiftUI'"
- Ensure you're building for macOS 13.0+
- Check Xcode version is 15.0+

### "Cannot find type 'Track' in scope"
- Verify all `.swift` files are added to the target
- Check File Inspector → Target Membership

### Build succeeds but app crashes
- Check Console output in Xcode (View → Debug Area → Show Debug Area)
- Common issue: File permissions for accessing music folders

---

## Building for Distribution

### Create Release Build

1. In Xcode: Product → Archive
2. Window → Organizer opens
3. Click "Distribute App"
4. Choose distribution method:
   - **Development**: For testing on your Mac
   - **Mac App Store**: For public distribution (requires paid Apple Developer account)
   - **Direct Distribution**: For sharing outside App Store

### Export Standalone App

```bash
# Build release version
xcodebuild -scheme HiResMusicPlayer -configuration Release

# Find the .app bundle
find ~/Library/Developer/Xcode/DerivedData -name "HiResMusicPlayer.app"

# Copy to Applications
cp -R path/to/HiResMusicPlayer.app /Applications/
```

---

## Quick Start Commands

```bash
# 1. Ensure you have Xcode
xcode-select -p

# 2. Navigate to project
cd ~/my-music-library/HiResMusicPlayer

# 3. Open in Xcode (after creating .xcodeproj)
open HiResMusicPlayer.xcodeproj

# 4. Build from command line
xcodebuild -scheme HiResMusicPlayer -configuration Release

# 5. Run the app
open build/Release/HiResMusicPlayer.app
```

---

## Estimated Time

- **First-time setup**: 10-15 minutes
- **Subsequent builds**: 30-60 seconds
- **Clean builds**: 2-3 minutes

---

## Next Steps After Compilation

1. ✅ Launch the app
2. ✅ Click "Open Folder"
3. ✅ Select your music directory
4. ✅ Start playing high-res audio!

For detailed setup instructions, see `SETUP_GUIDE.md`.
