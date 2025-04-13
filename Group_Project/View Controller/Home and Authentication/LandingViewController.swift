//
//  LandingViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//

import UIKit
import AVKit
import AVFoundation

class LandingViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    @IBAction func unwindToLanding(segue: UIStoryboardSegue) {
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideo()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        playerLayer?.frame = videoView.bounds
    }

    func setupVideo() {
        guard let path = Bundle.main.path(forResource: "steak", ofType: "mp4") else {
            print("Video file not found")
            return
        }
        let videoURL = URL(fileURLWithPath: path)

        
        player = AVPlayer(url: videoURL)
        player?.isMuted = true 

        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoView.bounds
        playerLayer?.videoGravity = .resizeAspectFill

        if let layer = playerLayer {
            videoView.layer.addSublayer(layer)
        }

       
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidEnd),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )

        player?.play()
    }

    @objc func videoDidEnd(notification: Notification) {
        player?.seek(to: .zero)
        player?.play()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
}

