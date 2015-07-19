//
//  ArtistDetailViewController.swift
//  Voxxel
//
//  Created by David Conner on 7/15/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit

class ArtistDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let artistService = ArtistService()
    var artist: Artist?
    var sounds = [Sound]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var imgArtist: UIImageView!
    
    @IBOutlet weak var lblSoundCount: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgArtist.image = artist?.photo
        lblArtistName.text = artist?.name()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        collectionView.alwaysBounceVertical = true
        
        sounds = artist?.sounds ?? []
        lblSoundCount.text = "\(sounds.count) Sounds"
        registerNibs()
    }
    
    func registerNibs() {
        let artistNib = UINib(nibName: "SoundCell", bundle: nil)
        collectionView.registerNib(artistNib, forCellWithReuseIdentifier: "soundCell")
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("soundCell", forIndexPath: indexPath) as! SoundCell
        
        let sound = sounds[indexPath.item]
        cell.lblName.text = sound.name
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO: user selects sound
    }
}

class SoundCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}