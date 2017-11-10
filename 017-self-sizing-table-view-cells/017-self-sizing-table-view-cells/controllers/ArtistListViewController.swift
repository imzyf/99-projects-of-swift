//
//  ViewController.swift
//  017-self-sizing-table-view-cells
//
//  Created by  moma on 2017/11/9.
//  Copyright © 2017年 yifans. All rights reserved.
//

import UIKit

class ArtistListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let artists = Artist.artistsFromBundle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        // bug: 在 ib 中设置此属性有问题，always big
        navigationController?.navigationBar.prefersLargeTitles = true
     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ArtistDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destination.selectedArtist = artists[indexPath.row]
        }
    }
}

extension ArtistListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArtistTableViewCell
        
        let artist = artists[indexPath.row]
        cell.artistImageView.image = UIImage(named: artist.image)
        cell.nameLabel.text = artist.name
        cell.bioLabel.text = artist.bio
        
        return cell
    }
}

