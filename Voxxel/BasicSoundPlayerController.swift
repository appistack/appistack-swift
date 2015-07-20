//
//  BasicSoundPlayerController.swift
//  Voxxel
//
//  Created by David Conner on 7/19/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class BasicSoundPlayerController: AVPlayerViewController {
    
    var sound: Sound?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player = AVPlayer(URL: (sound?.audiofileUrl())!)
    }
    
}
