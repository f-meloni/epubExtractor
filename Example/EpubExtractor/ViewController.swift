//
//  ViewController.swift
//  EpubExtractor
//
//  Created by f-meloni on 02/18/2017.
//  Copyright (c) 2017 f-meloni. All rights reserved.
//

import UIKit
import Foundation
import EpubExtractor

class ViewController: UIViewController {
    let epubs = [
        ("epub 2", [
            "Metamorphosis-jackson",
            "A-Room-with-a-View-morrison",
            "Beyond-Good-and-Evil-Galbraithcolor"
            ]
        ), ("epub3", [
            "moby-dick",
            "accessible_epub_3",
            "cole-voyage-of-life",
            "spanish-tales-epub3",
            "igp-epub-unleashed-01-2012",
            "kje-bible-books"
            ]
        )
    ]
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.epubs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.epubs[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "identifier")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "identifier")
        }
        
        cell?.textLabel?.text = self.epubs[indexPath.section].1[indexPath.item]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.epubs[section].0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! EpubDetailViewController
        detailVC.epubName = self.epubs[indexPath.section].1[indexPath.item]
        self.navigationController?.show(detailVC, sender: self)
    }
}

