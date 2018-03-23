//
//  VoxBridge.swift
//
//  This file is part of LyricsX
//  Copyright (C) 2017 Xander Deng - https://github.com/ddddxxx/LyricsX
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import AppKit
import ScriptingBridge


/*
 * Standard Suite
 */
// The application"s top level scripting object.
@objc protocol VoxApplication {
    @objc optional var name: String? {get}
    // The name of the application.
    @objc optional var frontmost: Bool {get}
    // Is this the frontmost (active) application?
    @objc optional var version: String? {get}
    // The version of the application.
    @objc optional func quit()
    // Quit an application.
    @objc optional func pause()
    // Pause playback.
    @objc optional func play()
    // Begin playback.
    @objc optional func playpause()
    // Toggle playback between playing and paused.
    @objc optional func next()
    // Skip to the next track in the playlist.
    @objc optional func previous()
    // Skip to the previous track in the playlist.
    @objc optional func shuffle()
    // Shuffle the tracks in the playlist.
    @objc optional func playUrl(x: String)
    // Play specified URL.
    @objc optional func addUrl(x: String)
    // Add specified URL to playlist
    @objc optional func rewindForward()
    // Rewind current track forward.
    @objc optional func rewindForwardFast()
    // Rewind current track forward fast.
    @objc optional func rewindBackward()
    // Rewind current track backward.
    @objc optional func rewindBackwardFast()
    // Rewind current track backward fast.
    @objc optional func increasVolume()
    // Increas volume.
    @objc optional func decreaseVolume()
    // Decrease volume.
    @objc optional func showHidePlaylist()
    // Show/Hide playlist.
    
    /*
     * Vox Suite
     */
    // The application"s top-level scripting object.
    @objc optional var tiffArtworkData: Data {get}
    // Current track artwork data in TIFF format.
    @objc optional var artworkImage: NSImage {get}
    // Current track artwork as an image.
    @objc optional var playerState: Int {get}
    // Player state (playing = 1, paused = 0)
    @objc optional var track: String? {get}
    // Current track title.
    @objc optional var trackUrl: String? {get}
    // Current track URL.
    @objc optional var artist: String? {get}
    // Current track artist.
    @objc optional var albumArtist: String? {get}
    // Current track album artist.
    @objc optional var album: String? {get}
    // Current track album.
    @objc optional var uniqueID: String? {get}
    // Unique identifier for the current track.
    @objc optional var currentTime: Double {get set}
    // The current playback position.
    @objc optional var totalTime: Double {get}
    // The total time of the currenty playing track.
    @objc optional var playerVolume: Double {get set}
    // Player volume (0.0 to 1.0)
    @objc optional var repeatState: Int {get set}
    // Player repeat state (none = 0, repeat one = 1, repeat all = 2)
}
extension SBApplication: VoxApplication{}
