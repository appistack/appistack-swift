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
        
        artistService.list() {(req, res, result) in
            switch result {
            case .Success(let value):
                self.artists = value
            case .Failure(let data, _):
                self.artists = []
            }
            self.collectionView.reloadData()
        }
    }
    
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

        cell.imgView.hnk_setImageFromURL(artist.headshotUrl(), success: { (img) in
            cell.imgView.image = img
            UIView.animateWithDuration(0.3, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
            })
        })
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ArtistCell {
            if let size = cell.imgView?.image?.size {
                return size
            }
        }
        return CGSize(width: 256, height: 256)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedArtist = artists[indexPath.item]
        performSegueWithIdentifier("navigateFromArtistsToDetail", sender: selectedArtist)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "navigateFromArtistsToDetail" {
            let controller = segue.destinationViewController as! ArtistDetailViewController
            controller.artist = sender as? Artist
        }
    }
}