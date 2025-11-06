import SwiftUI

@main
struct HiResMusicPlayerApp: App {
    @StateObject private var musicLibrary = MusicLibrary()
    @StateObject private var audioPlayer = AudioPlayer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(musicLibrary)
                .environmentObject(audioPlayer)
                .frame(minWidth: 900, minHeight: 600)
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("Open Folder...") {
                    musicLibrary.selectFolder()
                }
                .keyboardShortcut("o", modifiers: .command)
            }
        }
    }
}
