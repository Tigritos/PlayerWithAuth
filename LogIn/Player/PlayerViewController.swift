//
//  PlayerViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 30.12.2021.
//

import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
  
    var player: AVAudioPlayer? 
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var soundArtistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    
    private let viewModel = PlayerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    func configure(songs: [Song], position: Int) {
        viewModel.configure(songs: songs, position: position)
    }
    
    @IBAction func playButton(_ sender: Any) {
        viewModel.playTapped()
    }
    
    @IBAction func backwardButtonAction(_ sender: Any) {
        viewModel.backTappded()
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        viewModel.forwardTapped()
    }
    
    func configureView(_ model: PlayerViewUIModel) {
        imageView.image = UIImage(systemName: "questionmark")
        imageView.layer.cornerRadius = 15
        soundNameLabel.text = model.name
        soundArtistLabel.text = model.artistName
    }
    
    private func setIsPlaying(_ isPlaying: Bool) {
        if isPlaying {
            player?.play()
            playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            player?.pause()
            playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
}


extension PlayerViewController: PlayerViewModelDelegate {
    func setPlayerIsPlaying(_ isPlaying: Bool) {
        setIsPlaying(isPlaying)
    }
    
    func startPlaying(_ song: Song) {
        let playerViewUIModel = PlayerViewUIModel(from: song)
        configureView(playerViewUIModel)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(
                contentsOf: song.Url,
                fileTypeHint: AVFileType.mp3.rawValue
            )
            
            guard let player = player else { return }
            player.volume = 0.5
            setIsPlaying(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

struct PlayerViewUIModel {
    let name: String
    let artistName: String
    
    init(from song: Song) {
        self.name = song.name
        self.artistName = song.artistName
    }
}
