//
//  EpubDetailViewController.swift
//  EpubExstractor_Example
//
//  Created by Franco Meloni on 07/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import EpubExstractor

class EpubDetailViewController: UIViewController {
    private let epubExtractor = EPubExtractor()
    
    @IBOutlet weak var tableView: UITableView!
    
    var epubName: String? {
        didSet {
            self.epubExtractor.delegate = self
            let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let destinationURL = URL(string: destinationPath!)
            self.epubExtractor.extractEpub(epubURL: Bundle.main.url(forResource: epubName, withExtension: "epub")!, destinationFolder: destinationURL!)
        }
    }
    
    fileprivate var epub: Epub?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reusableIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EpubDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reusableIdentifier, for: indexPath) as! ImageCell
        
        if let coverPath = self.epub?.coverURL?.path {
            cell.coverImageView.image = UIImage(contentsOfFile: coverPath)
        }
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension EpubDetailViewController: EpubExtractorDelegate {
    func epubExactorDidExtractEpub(_ epub: Epub) {
        self.epub = epub
        self.tableView?.reloadData()
    }
    
    func epubExtractorDidFail(error: Error?) {
        print("error while extracting the epub: \(String(describing: error))")
    }
}
