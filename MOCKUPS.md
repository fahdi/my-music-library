# HiRes Music Player - Visual Mockups

## Main Window Layout

The app has a three-panel layout with a prominent now-playing bar at the bottom.

```
┌─────────────────────────────────────────────────────────────────────┐
│  ⚫ ⚫ ⚫                                          🔍 Search           │
├─────────┬───────────────────────────────────────────────────────────┤
│         │                                                           │
│ Library │                  ALBUM GRID VIEW                          │
│         │                                                           │
│ ◉ Albums│   ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐                   │
│   Tracks│   │ 🎵  │  │ 🎵  │  │ 🎵  │  │ 🎵  │                   │
│         │   │     │  │     │  │     │  │     │                   │
│         │   └─────┘  └─────┘  └─────┘  └─────┘                   │
│         │   Dark Side Pink Floyd Abbey Road Nevermind              │
│         │   of the Moon          The Beatles   Nirvana             │
│         │   12 tracks  14 tracks  17 tracks   13 tracks            │
│         │                                                           │
│         │   ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐                   │
│         │   │ 🎵  │  │ 🎵  │  │ 🎵  │  │ 🎵  │                   │
│         │   │     │  │     │  │     │  │     │                   │
│         │   └─────┘  └─────┘  └─────┘  └─────┘                   │
│         │   OK Computer Thriller    Random AM      In Rainbows     │
│         │   Radiohead   M. Jackson Access Mem.  Radiohead          │
│  ┌────┐ │   12 tracks  9 tracks  23 tracks    10 tracks           │
│  │📁  │ │                                                           │
│  │Open│ │                                                           │
│  └────┘ │                                                           │
│         │                                                           │
├─────────┴───────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─────┐  Bohemian Rhapsody                                        │
│  │ 🎵  │  Queen • A Night at the Opera                             │
│  │     │                                                            │
│  └─────┘  [24-bit] [96 kHz]                                        │
│                                                                     │
│           ▶️  ━━━━━━━━━━━━━━━●━━━━━━  🔊 ━━━●━━                   │
│              2:45                5:55                               │
└─────────────────────────────────────────────────────────────────────┘
```

## Album View (Hover Effect)

When you hover over an album, a play button appears:

```
┌──────────────────┐
│                  │
│                  │
│   ████████████   │
│   ████████████   │  ← Album artwork
│   ████████████   │
│   ████████████   │
│                  │
└──────────────────┘
 Dark Side of the Moon
 Pink Floyd
 12 tracks


         HOVER OVER IT ↓


┌──────────────────┐
│                  │
│   ████████████   │
│   ████▄▄▄▄████   │  ← Darkened overlay
│   ███┃▶️  ┃███   │  ← Big play button
│   ███┗━━━━┛███   │
│   ████████████   │
│                  │
└──────────────────┘
 Dark Side of the Moon
 Pink Floyd
 12 tracks
```

## Track List View

Detailed view showing all tracks with quality indicators:

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│       Title                    Artist          Album           Quality  Duration │
├─────────────────────────────────────────────────────────────────────────────────┤
│  🎵   Bohemian Rhapsody        Queen           A Night at..   24-bit  96kHz 5:55 │
│  🎵   Stairway to Heaven       Led Zeppelin    Led Zeppelin   24-bit  96kHz 8:02 │
│  🎵   Imagine                  John Lennon     Imagine        16-bit  44kHz 3:03 │
│  🎵 ▶ Smells Like Teen Spirit  Nirvana         Nevermind      24-bit 192kHz 5:01 │ ← Playing
│  🎵   Hotel California         Eagles          Hotel Calif..  24-bit  96kHz 6:30 │
│  🎵   Hey Jude                 The Beatles     The Beatles    16-bit  44kHz 7:11 │
│  🎵   Billie Jean              Michael Jackson Thriller       24-bit  96kHz 4:54 │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## Now Playing Bar (Detail View)

The bottom bar shows large album art and controls:

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                                                                   │
│  ┌──────────┐    Comfortably Numb                                                │
│  │          │                                                                     │
│  │  Album   │    Pink Floyd • The Wall                                           │
│  │   Art    │                                                                     │
│  │  Image   │    [24-bit] [192 kHz]  ← Quality badges                            │
│  │          │                                                                     │
│  │  (Large) │    ⏮  ▶️  ⏭   ━━━━━━━━━━━━━━●━━━━━━  🔊 ━━━━●━━                  │
│  │          │               3:24              6:23                                │
│  └──────────┘                                                                     │
│                                                                                   │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## Empty State

When you first launch the app:

```
┌─────────┬───────────────────────────────────────────────────────────┐
│         │                                                           │
│ Library │                                                           │
│         │                                                           │
│  Albums │                      🏠🎵                                 │
│  Tracks │                  (Large icon)                            │
│         │                                                           │
│         │              No Music Library                             │
│         │                                                           │
│         │          Open a folder to get started                     │
│         │                                                           │
│  ┌────┐ │                  ┌──────────────┐                        │
│  │📁  │ │                  │ Open Folder  │                        │
│  │Open│ │                  └──────────────┘                        │
│  └────┘ │                                                           │
│         │                                                           │
├─────────┴───────────────────────────────────────────────────────────┤
│  No track playing                                                   │
└─────────────────────────────────────────────────────────────────────┘
```

## Color Scheme

The app uses native macOS styling with:

- **Background**: System window background (light gray in light mode, dark in dark mode)
- **Accent Color**: System accent color (blue by default, but respects user preference)
- **Text**: Primary and secondary system colors for hierarchy
- **Album Art**: Full color, prominent display
- **Quality Badges**: Accent color with low opacity background
- **Hover Effects**: Subtle darkening with smooth animations

## Key Visual Features

1. **Large Album Artwork**
   - 180x180px in grid view
   - 100x100px in now playing bar
   - Rounded corners for modern look

2. **Quality Indicators**
   - Small badges showing bit depth (e.g., "24-bit")
   - Sample rate badges (e.g., "96 kHz")
   - Color-coded with accent color

3. **Smooth Hover Effects**
   - Albums darken and show play button on hover
   - Track rows highlight on hover
   - Animated transitions (0.15s ease-in-out)

4. **Clean Typography**
   - Headlines for track/album names
   - Subheadline for artists
   - Captions for metadata
   - System fonts for native feel

5. **Intuitive Controls**
   - Large play/pause button
   - Draggable seek slider
   - Volume slider with speaker icons
   - Keyboard shortcut (Cmd+O) for opening folders

## Window Sizing

- **Minimum**: 900x600 pixels
- **Recommended**: 1200x800 pixels for best experience
- **Resizable**: Yes, with responsive layout
- **Title Bar**: Hidden for cleaner look (controls in window chrome)

## Responsive Behavior

- **Album Grid**: Adapts to window width (minimum 180px per album)
- **Track List**: Fixed column widths with scrolling
- **Now Playing**: Always visible at bottom
- **Sidebar**: Fixed 200px width
