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
    ///Users/tigritos/Desktop/LogIn/LogIn/Audio
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        listOfFiles()
        listOfSongs()
        table.dataSource = self
        table.delegate = self
    }
    
    func listOfSongs() {
       
        let fileManager = FileManager.default
        let directoryPath = "/Users/tigritos/Desktop/LogIn/LogIn/Audio"
        let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: directoryPath)!
        while let element = enumerator.nextObject() as? String {
            if element.hasSuffix("mp3") { // checks the extension
                // DO my sound path stuff here
                // print(element)
                let soundURL = NSURL.fileURL(withPath: directoryPath + "/" + element)
                songsURLs.append(soundURL)
                
                let asset = AVAsset(url: soundURL)
                let metadata = asset.commonMetadata
                let titleID = AVMetadataIdentifier.commonIdentifierTitle
                let artistID = AVMetadataIdentifier.commonIdentifierArtist
                let imageID = AVMetadataIdentifier.commonIdentifierArtwork
                let titleItems = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: titleID
                )
                let  artistItems = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: artistID
                )
                let imageItems = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: imageID
                )
                
                if let songNameString = titleItems.first?.value?.description,
                   let artistNameString = artistItems.first?.value?.description,
                   let songImage = imageItems.first?.value {
                    print(songNameString)
                    songsTitles.append(songNameString)
                    songs.append(Song(name: songNameString,
                                      artistName: artistNameString,
                                      Url: soundURL))
                }
                /*
                let formatsKey = "availableMetadataFormats"
                
                asset.loadValuesAsynchronously(forKeys: [formatsKey]) {
                    var error: NSError? = nil
                    let status = asset.statusOfValue(forKey: formatsKey, error: &error)
                    if status == .loaded {
                        for format in asset.availableMetadataFormats {
                            let metadata = asset.metadata(forFormat: format)
                            
                            print(metadata)
                        }
                    }
                }
                */
                
                // print("sound URL", soundURL)
                
                
                // self.soundArray.append(soundElement)
                
            }
        }
//        print(songsTitles)
//        print(songsURLs)
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
        //cell.textLabel?.text = song.name
    
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController else {return}
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }

    
}

struct Song {
    let name: String
    let artistName: String
    let Url: URL
}
