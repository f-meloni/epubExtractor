//
//  TextExtractorViewController.swift
//  EpubExtractor_Example
//
//  Created by Alexandr Nesterov on 5/26/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import EpubExtractor

class TextExtractorViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var epub: Epub!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
    }
    
    func setupTextView() {
        textView.text = extractText()
    }
    
    func extractText() -> String {
        do {
            return try epub.allContent()
        } catch {
            return "there was an error: \(error)"
        }
    }
}
