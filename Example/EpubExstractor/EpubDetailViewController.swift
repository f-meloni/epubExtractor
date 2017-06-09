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

private let imageIndex = 0
private let titleIndex = 1
private let authorIndex = 2
private let publisherIndex = 3
private let languageIndex = 3

extension EpubDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case imageIndex:
            return self.imageCell(indexPath: indexPath)
        case titleIndex:
            return self.titleCell(indexPath: indexPath)
        case authorIndex:
            return self.authorCell(indexPath: indexPath)
        case publisherIndex:
            return self.publisherCell(indexPath: indexPath)
        case languageIndex:
            return self.languageCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == imageIndex {
            return 250
        }
        
        return UITableViewAutomaticDimension
    }
    
    private func imageCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ImageCell.reusableIdentifier, for: indexPath) as! ImageCell
        
        if let coverPath = self.epub?.coverURL?.path {
            cell.coverImageView.image = UIImage(contentsOfFile: coverPath)
        }
        
        return cell
    }
    
    private func titleCell(indexPath: IndexPath) -> UITableViewCell {
        return self.commonCell(indexPath: indexPath, title: "Title", value: self.epub?.title)
    }
    
    private func authorCell(indexPath: IndexPath) -> UITableViewCell {
        return self.commonCell(indexPath: indexPath, title: "Author", value: self.epub?.author)
    }
    
    private func publisherCell(indexPath: IndexPath) -> UITableViewCell {
        return self.commonCell(indexPath: indexPath, title: "Publisher", value: self.epub?.publisher)
    }
    
    private func languageCell(indexPath: IndexPath) -> UITableViewCell {
        return self.commonCell(indexPath: indexPath, title: "Language", value: self.epub?.language)
    }
    
    private func identifierCell(indexPath: IndexPath) -> UITableViewCell {
        return self.commonCell(indexPath: indexPath, title: "Identifier", value: self.epub?.identifier)
    }
    
    private func commonCell(indexPath: IndexPath, title: String, value: String?) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "CommonCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "CommonCell")
        }
        
        cell?.textLabel?.text = title
        cell?.detailTextLabel?.text = value
        
        return cell!
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
