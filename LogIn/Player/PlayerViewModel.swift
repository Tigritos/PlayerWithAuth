//
//  PlayerViewModel.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 13.01.2022.
//

import Foundation
import AVFoundation

protocol PlayerViewModelDelegate: AnyObject {
    func setPlayerIsPlaying(_ isPlaying: Bool)
    func startPlaying(_ song: Song)
}


final class PlayerViewModel {
    
    weak var delegate: PlayerViewModelDelegate?
    
    
    private var songs: [Song] = []
    private var position: Int = 0
    
    func configure(songs: [Song], position: Int) {
        self.songs = songs
        self.position = position
    }
    
    private var isPlaying = false {
        didSet {
            delegate?.setPlayerIsPlaying(isPlaying)
        }
    }
    
    func viewDidLoad() {
        let song = currentSong()
        delegate?.startPlaying(song)
    }

    func playTapped() {
        isPlaying = !isPlaying
    }
    
    func backTappded() {
        if position > 0 {
            position = position - 1
        } else {
            position = songs.count - 1
        }
        let song = currentSong()
        delegate?.startPlaying(song)
    }
    
    func forwardTapped() {
        if position < (songs.count - 1) {
            position = position + 1
        } else {
            position = 0
        }
        let song = currentSong()
        delegate?.startPlaying(song)
        
    }
    
    private func currentSong() -> Song {
        let song = songs[position]
        return song
    }
    
}
