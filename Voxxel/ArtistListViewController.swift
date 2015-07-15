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
        //TODO: load asynchronously
//        cell.imgView.hnk_setImageFromURL(artists[indexPath.item].headshotUrl())
        cell.imgView.hnk_setImageFromURL(artists[indexPath.item].headshotUrl(), success: {(img) in
//             TODO: haneke is breaking with callback that does nothing
//            self.collectionView.reloadItemsAtIndexPaths([indexPath])
            self.collectionView.reloadData()
        })
        
        cell.backgroundColor = UIColor.whiteColor()
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
}

//TODO: move to separate file later
class ArtistCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}