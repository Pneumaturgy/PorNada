# Audio & Dynamic Music System

The audio system in **Por Nada** is designed to adapt to the game's core loop, providing a dynamic and procedural soundtrack experience that shifts between game states.

## 🎵 Jukebox System (`JukeBox.tscn`)

The `JukeBox` is the central node responsible for background music. It is managed by `Main.gd` and interacts with custom playlist resources.

### Music Playlist Resource (`music_playlist_resource.gd`)
A custom `Resource` type that stores an array of `AudioStream` tracks. This allows for easy categorization of music into different atmospheric groups.

- **Class Name**: `MusicPlaylistResource`
- **Properties**: `audio_tracks` (Array of `AudioStream`)

## 🔄 Dynamic State-Based Playlists

The background music changes dynamically based on the game's current phase:

| Phase | Resource Name | Atmospheric Goal |
| :--- | :--- | :--- |
| **Dawn** | `DawnPlaylistResource.tres` | Preparation and setup tension. |
| **Day** | `DayPlaylistResource.tres` | High-energy combat music. |
| **Night** | `NightPlaylistResource.tres` | Atmospheric and eerie looting phase. |

### Procedural Selection Logic
The music isn't just a static loop; it uses a randomized selection process within each state:

1. **Random Shuffling**: When a phase starts or a track finishes, `Main.gd` selects a random track from the current `MusicPlaylistResource`.
2. **Infinite Playback**: Once a track is chosen, it is set to loop and played.
3. **Transition Trigger**: The state timers (`DawnTimer`, `DayTimer`, `NightTimer`) in `Main.gd` trigger the switch to the next playlist, ensuring the music always matches the gameplay intensity.

```gdscript
func update_jukebox():
    if first_tick:
        juke_box.stream = next_playlist.audio_tracks[randi_range(0,next_playlist.audio_tracks.size()-1)]
        juke_box.stream.loop = true
        juke_box.play()
```

## 🔊 Sound Effects & Cleanup

To keep the scene tree clean, transient sound effects (like explosions or hits) use an automated cleanup system.

### `DestroyOnSoundFinished` (`destroy_on_sound_finished.gd`)
Attached to transient nodes that contain an `AudioStreamPlayer` and often `GPUParticles2D`.
- **Function**: Automatically calls `queue_free()` when the `finished()` signal is emitted by the audio player.
- **Visuals**: Often synchronizes particle emission with the sound duration.

## 🛠 Adding New Music
1. Import your audio files into `res://Assets/Audio/`.
2. Open the desired `MusicPlaylistResource.tres` in the inspector.
3. Add the new `AudioStream` to the `audio_tracks` array.
4. The Jukebox will automatically include it in the procedural rotation for that phase.
