//
//  HomeViewController.swift
//  LogIn
//
//  Created by Tigran Oganisyan on 26.12.2021.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var table: UITableView!
    
    var songs = [Song]()
    var songsTitles = [String]()
    var songsURLs = [URL]()
    var player: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listOfSongs()
        table.dataSource = self
        table.delegate = self
    }
    
    func listOfSongs() {
        let fileManager = FileManager.default
        let directoryPath = "/Users/tigritos/Documents/Projects/MusicApp/LogIn/Audio"
        let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: directoryPath)!
        while let element = enumerator.nextObject() as? String {
            if element.hasSuffix("mp3") {
                let soundURL = NSURL.fileURL(withPath: directoryPath + "/" + element)
                songsURLs.append(soundURL)
                
                let asset = AVAsset(url: soundURL)
                let metadata = asset.commonMetadata
                let titleID = AVMetadataIdentifier.commonIdentifierTitle
                let artistID = AVMetadataIdentifier.commonIdentifierArtist
                let titleItems = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: titleID
                )
                let  artistItems = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: artistID
                )
                
                if let songNameString = titleItems.first?.value?.description,
                   let artistNameString = artistItems.first?.value?.description {
                    print(songNameString)
                    songsTitles.append(songNameString)
                    songs.append(Song(name: songNameString,
                                      artistName: artistNameString,
                                      Url: soundURL))
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = song.name
        content.secondaryText = song.artistName
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = indexPath.row
        guard let playerVC = UIStoryboard(name: "PlayerStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController else {return}
        playerVC.configure(songs: songs, position: position)
        self.present(playerVC, animated: true)
    }
    
}

struct Song {
    let name: String
    let artistName: String
    let Url: URL
}
