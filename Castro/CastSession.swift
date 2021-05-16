//
//  CastSession.swift
//  Castro
//
//  Created by Bartosz Stokrocki on 16/05/2021.
//
import GoogleCast

class CastSession {
    private var mediaPlayer: GCKRemoteMediaClient?
    private var currentMetadata: GCKMediaMetadata?
    private var currentStatus: GCKMediaStatus?
    
    var isPlaying: Bool {
        return currentStatus?.playerState == GCKMediaPlayerState.playing
    }
    
    func onMetadataUpdated(client: GCKRemoteMediaClient, metadata: GCKMediaMetadata?) {
        if (self.mediaPlayer != client) {
            self.mediaPlayer = client
        }
        
        self.currentMetadata = metadata
    }
    
    func onStatusUpdated(client: GCKRemoteMediaClient, status: GCKMediaStatus?) {
        if (self.mediaPlayer != client) {
            self.mediaPlayer = client
        }
        
        self.currentStatus = status
    }
    
    func onSessionClosed() {
        mediaPlayer = nil
        currentMetadata = nil
        currentStatus = nil
    }
}
