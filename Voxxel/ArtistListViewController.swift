//
//  ArtistListViewController.swift
//  Voxxel
//
//  Created by David Conner on 7/12/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit

//TODO: genericize for tags after implementing tags in the API?
class ArtistListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let artistService = ArtistService()
    var artists = [Artist]()
    var selectedArtist: Artist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupCollectionView()
        registerNibs()
        
        artistService.list() {(req, res, artists, err) in
            self.artists = artists!
            self.collectionView.reloadData()
        }
    }

    //Collection view renders items correctly when forced to reload itmes (i.e. during fullscreen transition on iphone 6+)
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//    }
    
    func setupCollectionView() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        self.collectionView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.collectionViewLayout = layout
    }
    
    func registerNibs() {
        let artistNib = UINib(nibName: "ArtistCell", bundle: nil)
        collectionView.registerNib(artistNib, forCellWithReuseIdentifier: "artistCell")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("artistCell", forIndexPath: indexPath) as! ArtistCell
        var artist = artists[indexPath.item]
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.lblName.text = artist.name()
        
        if artist.photo != nil {
            cell.imgView.image = artist.photo
            return cell
        }
        
        artist.loadPhoto(artist.headshotUrl()) { (art, err) in
            if (err != nil) {
                return
            }

            cell.imgView.image = artist.photo
            self.collectionView.reloadItemsAtIndexPaths([indexPath])
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let artist = artists[indexPath.item]
        return artist.photo?.size ?? CGSize(width: 256, height: 256)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedArtist = artists[indexPath.item]
        performSegueWithIdentifier("navigateFromArtistsToDetail", sender: selectedArtist)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "navigateFromArtistsToDetail" {
            // TODO: set artist in segue or in the didSelectItem?
            let controller = segue.destinationViewController as! ArtistDetailViewController
            controller.artist = selectedArtist
        }
    }
}

//TODO: move to separate file later
class ArtistCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}