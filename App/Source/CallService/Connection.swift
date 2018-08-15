//
//  Connection.swift
//  Caller
//
//  Created by Yaroslav Pasternak on 01.08.2018.
//  Copyright © 2018 Teambrella. All rights reserved.
//

import Foundation
import WebRTC

class Connection: NSObject {
    let fabric = RTCPeerConnectionFactory()
    lazy var peerConnection: RTCPeerConnection = self.createConnection()

    let stunServers: [RTCIceServer]

    var localAudioTrack: RTCAudioTrack?
    var localMediaStream: RTCMediaStream?

    var constraints: RTCMediaConstraints {
        return RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
    }

    init(stunServers: [RTCIceServer]) {
        self.stunServers = stunServers
        super.init()
    }

    private func createConnection() -> RTCPeerConnection {
        let peerConnection = self.fabric.peerConnection(with: makeConfig(),
                                                        constraints: constraints,
                                                        delegate: self)

        self.localMediaStream = fabric.mediaStream(withStreamId: "localMediaStream")
        self.createLocalAudioTrack()
        if let localAudioTrack = localAudioTrack {
            localMediaStream?.addAudioTrack(localAudioTrack)
        }
        return peerConnection
    }

    func offer(completion: @escaping (String) -> Void, failure: ((Error?) -> Void)? = nil) {
        peerConnection.offer(for: constraints, completionHandler: { description, error in
            if let description = description {
                print("Intermediate result: \(description)")
                self.peerConnection.setLocalDescription(description, completionHandler: { error in
                    guard error == nil else {
                        failure?(error)
                        return
                    }

                    completion(description.sdp)
                })
            } else {
                failure?(error)
            }
        })
    }

    func receive(sdpString: String, completion: @escaping (Error?) -> Void) {
        let sdp = RTCSessionDescription(type: .offer, sdp: sdpString)
        peerConnection.setRemoteDescription(sdp, completionHandler: completion)
    }

    func answer(completion: @escaping (String) -> Void, failure: ((Error?) -> Void)? = nil) {
        peerConnection.answer(for: constraints, completionHandler: { description, error in
            if let description = description {
                self.peerConnection.setLocalDescription(description, completionHandler: { error in
                    guard error == nil else {
                        failure?(error)
                        return
                    }

                    completion(description.sdp)
                })
            } else {
                failure?(error)
            }
        })
    }

    private func makeConfig() -> RTCConfiguration {
            let config = RTCConfiguration()
            config.iceServers = self.stunServers
            return config
    }

    private func createLocalAudioTrack() {
        let audioSource = fabric.audioSource(with: constraints)
        localAudioTrack = fabric.audioTrack(with: audioSource, trackId: "LocalAudioTrack")
    }

}

extension Connection: RTCPeerConnectionDelegate {
    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        print("\(#file) \(#function)")
        print("Peer connection created ice candidate: \(candidate)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection, didStartReceivingOn transceiver: RTCRtpTransceiver) {
        print("\(#file) \(#function)")
    }

    func peerConnection(_ peerConnection: RTCPeerConnection,
                        didAdd rtpReceiver: RTCRtpReceiver,
                        streams mediaStreams: [RTCMediaStream]) {
        print("\(#file) \(#function)")
    }
}
