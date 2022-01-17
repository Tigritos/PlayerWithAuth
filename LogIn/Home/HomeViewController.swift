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
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let countOfSongs = viewModel.getSongsCount()
        return countOfSongs
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let songContent = viewModel.getSongContent(songPosition: indexPath.row)
        content.text = songContent?.name
        content.secondaryText = songContent?.artistName
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let position = indexPath.row
        guard let playerVC = UIStoryboard(name: "PlayerStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController else {return}
        playerVC.configure(songs: viewModel.getSongs(), position: position)
        self.present(playerVC, animated: true)
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    
}

