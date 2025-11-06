# Setup Guide: Creating the Xcode Project

Since Xcode projects can only be properly created using Xcode itself, follow these detailed steps to set up your HiRes Music Player app.

## Step-by-Step Instructions

### 1. Open Xcode

Launch Xcode on your Mac. If you don't have Xcode installed, download it from the Mac App Store.

### 2. Create a New Project

1. Click "Create a new Xcode project" or go to **File** > **New** > **Project**
2. In the template chooser, select **macOS** tab at the top
3. Choose **App** template
4. Click **Next**

### 3. Configure Project Settings

Fill in the following details:

- **Product Name**: `HiResMusicPlayer`
- **Team**: Select your Apple Developer team (or leave as "None" for local development)
- **Organization Identifier**: Use something like `com.yourname` or `com.example`
- **Bundle Identifier**: This will auto-generate (e.g., `com.yourname.HiResMusicPlayer`)
- **Interface**: Select **SwiftUI**
- **Language**: Select **Swift**
- **Storage**: Select **None**
- **Include Tests**: Uncheck both boxes (optional)

Click **Next**

### 4. Choose Location

1. Navigate to the `my-music-library` folder
2. **Important**: Uncheck "Create Git repository on my Mac" (we already have one)
3. Click **Create**

### 5. Replace Default Files

Xcode will create some default files. We need to replace them with our custom implementation:

1. In the **Project Navigator** (left sidebar), find these files:
   - `HiResMusicPlayerApp.swift`
   - `ContentView.swift`

2. **Delete** these files (right-click > Delete > Move to Trash)

### 6. Add Source Files

1. In Finder, navigate to `my-music-library/HiResMusicPlayer/Sources/`
2. Select **all** `.swift` files in this folder
3. Drag them into your Xcode project (into the main project folder in the Project Navigator)
4. In the dialog that appears:
   - ✅ Check "Copy items if needed"
   - ✅ Ensure "Create groups" is selected
   - ✅ Make sure your app target is checked
   - Click **Finish**

The files you should add:
- `HiResMusicPlayerApp.swift`
- `Models.swift`
- `AudioPlayer.swift`
- `MusicLibrary.swift`
- `ContentView.swift`
- `AlbumsView.swift`
- `TracksView.swift`
- `NowPlayingBar.swift`

### 7. Configure Project Settings

1. Click on the project name at the top of the Project Navigator
2. Select your app target (under TARGETS)
3. Go to the **General** tab
4. Under **Deployment Info**:
   - Set **Minimum Deployment** to **macOS 13.0** or later

### 8. Add Info.plist (Optional)

If you want custom Info.plist settings:

1. Drag `HiResMusicPlayer/Resources/Info.plist` into your project
2. In the project settings, under **Build Settings**, search for "Info.plist"
3. Set the path to your Info.plist file

### 9. Build and Run

1. Select your Mac as the destination in the toolbar (next to the Run button)
2. Press **Cmd+R** or click the **Run** button (▶️)
3. The app should build and launch!

## First Run

When the app launches for the first time:

1. You'll see an empty library screen
2. Click **"Open Folder"** button
3. Navigate to a folder containing your music files
4. The app will scan the folder and display your music library
5. Click on any album or track to start playing

## Troubleshooting

### Build Errors: "Cannot find type 'Track'" or similar

**Solution**: Make sure all `.swift` files were properly added to the target
- Select each file in Project Navigator
- Check the **File Inspector** (right sidebar)
- Under **Target Membership**, ensure your app target is checked

### Build Errors: Missing imports

**Solution**: The app uses only standard macOS frameworks:
- SwiftUI
- AVFoundation
- AppKit
- Foundation

These should all be available by default. Try cleaning the build folder:
- **Product** > **Clean Build Folder** (Shift+Cmd+K)
- Then rebuild (Cmd+B)

### App crashes on launch

**Solution**: Check the Console in Xcode for error messages
- Ensure minimum deployment target is set correctly
- Check that all files compiled successfully

### "Cannot load folder" or permission errors

**Solution**:
- Make sure you grant the app permission to access folders
- macOS may show a permission dialog the first time
- Check **System Settings** > **Privacy & Security** > **Files and Folders**

## Next Steps

Once the app is running successfully:

1. Test with different music folders
2. Try various audio formats (FLAC, ALAC, WAV, etc.)
3. Check that album art displays correctly
4. Test playback controls
5. Try the search functionality

## Customization

Feel free to customize the app:

- **Colors**: Modify the `.accentColor` calls in the SwiftUI views
- **Layout**: Adjust spacing, sizing in the view files
- **Features**: Add new functionality by editing the source files

## Need Help?

If you encounter issues:

1. Check that you're using macOS 13.0 or later
2. Ensure Xcode is up to date (15.0+)
3. Verify all source files are included in the target
4. Clean and rebuild the project
5. Check the Xcode console for specific error messages

Enjoy your high-resolution music player!
