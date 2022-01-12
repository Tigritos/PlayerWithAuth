//
//  PlayerViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 30.12.2021.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var songs: [Song] = []
    public var position: Int = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var soundArtistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

    }
    
    private var isPlaying = false {
        didSet {
            updatePlayerState()
            configureButtonImage()
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        isPlaying = !isPlaying
    }
    
    private func updatePlayerState() {
        if isPlaying {
            player?.play()
        } else {
            player?.pause()
        }
    }
    
    private func configureButtonImage() {
        let image: UIImage? = isPlaying
            ? UIImage(systemName: "pause.fill")
            : UIImage(systemName: "play.fill")
        playPauseButton.setImage(image , for: .normal)
        
    }
    
    func configure() {
        let song = songs[position]
        soundNameLabel.text = song.name
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: song.Url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.volume = 0.5
            isPlaying = false
        } catch let error {
            print(error.localizedDescription)
        }
        
        
    }
}
