//
//  ArtistDetailViewController.swift
//  Voxxel
//
//  Created by David Conner on 7/15/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit

class ArtistDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let artistService = ArtistService()
    var artist: Artist?
    var sounds = [Sound]()
    
    @IBOutlet weak var tblSounds: UITableView!
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var imgArtist: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgArtist.hnk_setImageFromURL(artist!.headshotUrl())
        lblArtistName.text = artist?.name()
        
        setupTableView()
        registerNibs()
        
        artistService.get(artist!.id) {(req, res, result) in
            switch result {
            case .Success(let value):
                self.artist = value
                self.sounds = value.sounds
            case .Failure:
                self.artist = nil
                self.sounds = []
            }
            
            self.tblSounds.reloadData()
        }
    }
    
    func setupTableView() {
        tblSounds.dataSource = self
        tblSounds.delegate = self
        tblSounds.rowHeight = UITableViewAutomaticDimension
        tblSounds.estimatedRowHeight = 80
        tblSounds.alwaysBounceVertical = true
        // tblSounds.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    }
    
    func registerNibs() {
        let soundNib = UINib(nibName: "SoundCell", bundle: nil)
        tblSounds.registerNib(soundNib, forCellReuseIdentifier: "soundCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tblSounds.dequeueReusableCellWithIdentifier("soundCell", forIndexPath: indexPath) as! SoundCell
        
        let sound = sounds[indexPath.item]
        cell.lblName.text = sound.name
        cell.lblDesc.text = sound.desc
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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