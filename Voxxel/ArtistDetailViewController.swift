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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgArtist.image = artist?.photo
        lblArtistName.text = artist?.name()
        
        setupCollectionView()
        registerNibs()
        
        artistService.get(artist!.id) {(req, res, artist, err) in
            self.sounds = artist!.sounds
            self.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        collectionView.alwaysBounceVertical = true
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedSound = sounds[indexPath.item]
        performSegueWithIdentifier("navigateToSoundFromArtist", sender: selectedSound)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "navigateToSoundFromArtist" {
            let controller = segue.destinationViewController as! SoundDetailViewController
            controller.sound = sender as? Sound
        }
    }
}

class SoundCell: UICollectionViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}