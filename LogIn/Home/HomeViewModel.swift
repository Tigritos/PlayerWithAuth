//
//  HomeViewModel.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 17.01.2022.
//

import Foundation
import AVFoundation
import UIKit

protocol HomeViewModelDelegate: AnyObject {
    
}

final class HomeViewModel {
    
    private var songs = [Song]()
    
    func viewDidLoad() {
        setupSongList()
    }
    
    private func setupSongList() {
        let fileManager = FileManager.default
        let directoryPath = "/Users/tigritos/Documents/Projects/MusicApp/LogIn/Audio"
        let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: directoryPath)!
        while let element = enumerator.nextObject() as? String {
            if element.hasSuffix("mp3") {
                let soundURL = NSURL.fileURL(withPath: directoryPath + "/" + element)
                
                let asset = AVAsset(url: soundURL)
                let metadata = asset.commonMetadata
                let titleID = AVMetadataIdentifier.commonIdentifierTitle
                let artistID = AVMetadataIdentifier.commonIdentifierArtist
                let titleItems = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: titleID
                )
                let artistItems = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: artistID
                )
                
                guard
                    let songNameString = titleItems.first?.value?.description,
                    let artistNameString = artistItems.first?.value?.description
                else { return }
                songs.append(
                    Song(
                        name: songNameString,
                        artistName: artistNameString,
                        url: soundURL
                    )
                )
                
            }
        }
    }
    
    func getSongs() -> [Song] {
        return songs
    }
    
    func getSongsCount() -> Int {
        return songs.count
    }
    
    func getSongContent(songPosition: Int) -> SongCellContentModel? {
        guard let song = songs[safe: songPosition] else { return nil }
        let cellContentModel = SongCellContentModel(from: song)
        return cellContentModel
    }
    
}

struct Song {
    let name: String
    let artistName: String
    let url: URL
}

struct SongCellContentModel {
    let name: String
    let artistName: String
    
    init(from song: Song) {
        self.name = song.name
        self.artistName = song.artistName
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
