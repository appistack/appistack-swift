//
//  ArtistDetailViewController.swift
//  Voxxel
//
//  Created by David Conner on 7/15/15.
//  Copyright © 2015 Voxxel. All rights reserved.
//

import Foundation
import UIKit

class ArtistDetailViewController: UIViewController {
    var artist: Artist?
    
    @IBOutlet weak var lblArtistName: UILabel!
    @IBOutlet weak var imgArtist: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgArtist.hnk_setImageFromURL((artist?.headshotUrl())!)
        lblArtistName.text = artist?.name()
    }
}