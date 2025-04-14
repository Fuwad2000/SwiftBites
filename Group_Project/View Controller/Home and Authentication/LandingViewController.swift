//
//  LandingViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//
//  This class manages the landing screen with background video and navigation options.
//  Principal author: Fuwad Oladega

import UIKit
import AVKit
import AVFoundation

class LandingViewController: UIViewController {
    
    /// Container view for the background video
    @IBOutlet weak var videoView: UIView!

    /// Video player for background content
    var player: AVPlayer?
    
    /// Layer for displaying the video content
    var playerLayer: AVPlayerLayer?
    
    /// Unwind segue handler when returning to the landing screen
    /// - Parameter segue: The segue being unwound
    @IBAction func unwindToLanding(segue: UIStoryboardSegue) {
       
    }

    /// Set up the view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideo()
    }

    /// Adjust video layer when the view layout changes
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the player layer frame to match the container view
        playerLayer?.frame = videoView.bounds
    }

    /// Configure and start the background video
    func setupVideo() {
        guard let path = Bundle.main.path(forResource: "steak", ofType: "mp4") else {
            print("Video file not found")
            return
        }
        let videoURL = URL(fileURLWithPath: path)

        // Create player with the video URL
        player = AVPlayer(url: videoURL)
        player?.isMuted = true 

        // Configure the player layer
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoView.bounds
        playerLayer?.videoGravity = .resizeAspectFill

        if let layer = playerLayer {
            videoView.layer.addSublayer(layer)
        }

        // Add observer to loop the video
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidEnd),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )

        player?.play()
    }

    /// Handle video end event to loop playback
    /// - Parameter notification: The notification that triggered this method
    @objc func videoDidEnd(notification: Notification) {
        // Reset to beginning and play again
        player?.seek(to: .zero)
        player?.play()
    }

    /// Clean up observers when the view controller is deallocated
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
}

