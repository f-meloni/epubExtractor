//
//  ViewController.swift
//  EpubExstractor
//
//  Created by f-meloni on 02/18/2017.
//  Copyright (c) 2017 f-meloni. All rights reserved.
//

import UIKit
import Foundation
import EpubExstractor

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let destinationURL = URL(string: destinationPath!)
        
        EPubExtractor().extractEpub(epubURL: Bundle.main.url(forResource: "moby-dick", withExtension: "epub")!, destinationFolder: destinationURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

