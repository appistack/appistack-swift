//
//  SoundDetailViewController.swift
//  Voxxel
//
//  Created by David Conner on 7/19/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit

class SoundDetailViewController: UIViewController {
    var soundService = SoundService()
    var sound: Sound?
    
    @IBOutlet weak var lblSoundName: UILabel!
    @IBOutlet weak var lblSoundDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblSoundName.text = sound?.name
        lblSoundDesc.text = sound?.desc
    }
    
    @IBAction func didClickOpenPlayer(sender: AnyObject) {
        performSegueWithIdentifier("playSoundInBasicPlayer", sender: sound)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "playSoundInBasicPlayer" {
            let controller = segue.destinationViewController as! BasicSoundPlayerController
            controller.sound = sender as? Sound
        }
    }
    
}