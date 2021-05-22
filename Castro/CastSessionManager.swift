//
//  CastListener.swift
//  Castro
//
//  Created by Bartosz Stokrocki on 16/05/2021.
//

import GoogleCast

class CastSessionManager: NSObject, GCKDiscoveryManagerListener, GCKSessionManagerListener, GCKRemoteMediaClientListener {
    private let kDebugLoggingEnabled: Bool
    private var castLogger: CastLogger?
    
    private var sessionManager: GCKSessionManager {
        return GCKCastContext.sharedInstance().sessionManager
    }
    private var discoveryManager: GCKDiscoveryManager {
        return GCKCastContext.sharedInstance().discoveryManager
    }
    
    private var currentCastDevice: GCKDevice?
    private var currentCastSession = CastSession()
    
    init(debugLoggingEnabled: Bool = false) {
        self.kDebugLoggingEnabled = debugLoggingEnabled
        super.init()
        
        // Set your receiver application ID.
        let options = GCKCastOptions(discoveryCriteria: GCKDiscoveryCriteria(applicationID: kGCKDefaultMediaReceiverApplicationID))
//        let options = GCKCastOptions(discoveryCriteria: GCKDiscoveryCriteria(applicationID: "233637DE"))
        options.physicalVolumeButtonsWillControlDeviceVolume = true
        options.suspendSessionsWhenBackgrounded = false
//
        GCKCastContext.setSharedInstanceWith(options)
        
        if (kDebugLoggingEnabled) {
            castLogger = CastLogger()
            setupCastLogging(logger: castLogger!)
        }
        
        discoveryManager.add(self)
        discoveryManager.startDiscovery()
    }
    
    //Called when device is found
    func didInsert(_ device: GCKDevice, at index: UInt) {
        discoveryManager.remove(self)
        discoveryManager.stopDiscovery()
        
        currentCastDevice = device
        print("device found")
        sessionManager.add(self)
        
        //It's important to override the default applicationID here, otherwise default cast
        //app will be started and existing session will be interrupted
        sessionManager.startSession(with: device, sessionOptions: ["gck_applicationID": NSString()])
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didStart session: GCKCastSession) {
        print("56")
        
        if let client = session.remoteMediaClient {
            client.add(self)
        }
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didResumeCastSession session: GCKCastSession) {
        print("64")
        
        if let client = session.remoteMediaClient {
            client.add(self)
        }
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, willEnd session: GCKCastSession) {
        print("72")
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, willStart session: GCKCastSession) {
        print("76")
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, willResumeCastSession session: GCKCastSession) {
        print("80")
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didUpdateDefaultSessionOptionsForDeviceCategory category: String) {
        print("84")
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didEnd session: GCKCastSession, withError error: Error?) {
        print("88")
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didSuspend session: GCKCastSession, with reason: GCKConnectionSuspendReason) {
        print("92")
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, castSession session: GCKCastSession, didReceiveDeviceStatus statusText: String?) {
        print("96")
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, castSession session: GCKCastSession, didReceiveDeviceVolume volume: Float, muted: Bool) {
        print("100")
    }
    
    func sessionManager(_ sessionManager: GCKSessionManager, didFailToStart session: GCKCastSession, withError error: Error) {
        print("104")
    }
    
    func remoteMediaClient(_ client: GCKRemoteMediaClient, didUpdate mediaStatus: GCKMediaStatus?) {
        currentCastSession.onStatusUpdated(client: client, status: mediaStatus)
    }
    
    func remoteMediaClient(_ client: GCKRemoteMediaClient, didUpdate mediaMetadata: GCKMediaMetadata?) {
        currentCastSession.onMetadataUpdated(client: client, metadata: mediaMetadata)
    }
       
    func setupCastLogging(logger: CastLogger) {
        let logFilter = GCKLoggerFilter()
        let classesToLog = [
            "GCKDeviceScanner",
            "GCKDeviceProvider",
            "GCKDiscoveryManager",
            "GCKCastChannel",
            "GCKMediaControlChannel",
            "GCKUICastButton",
            "GCKUIMediaController",
            "NSMutableDictionary"
        ]
        logFilter.setLoggingLevel(.verbose, forClasses: classesToLog)
        GCKLogger.sharedInstance().filter = logFilter
                
        GCKLogger.sharedInstance().delegate = logger
    }
}

class CastLogger : NSObject, GCKLoggerDelegate {
    func logMessage(_ message: String,
                      at _: GCKLoggerLevel,
                      fromFunction function: String,
                      location: String) {
        print("\(location): \(function) - \(message)")
    }
}
