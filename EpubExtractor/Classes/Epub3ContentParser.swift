//
//  Epub3ContentParser.swift
//  Pods
//
//  Created by Franco Meloni on 17/04/2017.
//
//

import UIKit
import AEXML

struct Epub3ContentParser: EPubContentParser {
    let contentURL: URL
    var chapters: [ChapterItem] = []
    
    init(manifest: [String:ManifestItem], epubContentsURL: URL) {
        var contentFilePath = ""
        
        if manifest["toc"]?.href != nil {
            contentFilePath = (manifest["toc"]?.href)!
        } else if manifest["htmltoc"]?.href != nil {
            contentFilePath = (manifest["htmltoc"]?.href)!
        } else if manifest["nav"]?.href != nil {
            contentFilePath = (manifest["nav"]?.href)!
        }
        
        self.contentURL = URL(fileURLWithPath: epubContentsURL.appendingPathComponent(contentFilePath).path)
        self.chapters = self.parseChapters(epubContentsURL: self.contentURL)
    }
    
    func parseChapters(epubContentsURL: URL) -> [ChapterItem] {
        guard let contentData = try? Data(contentsOf: self.contentURL),
            let contentDocument = try? AEXMLDocument(xml: contentData) else {
                return []
        }
        
        var chapters: [ChapterItem] = []
        
        let navItems = contentDocument.root["body"]["nav"].all?.count ?? 0 > 0 ? contentDocument.root["body"]["nav"] : contentDocument.root["body"]["section"]["nav"]
        
        if let tocElement = navItems.all(withAttributes: ["epub:type":"toc"])?.first {
            for chapterElement in tocElement["ol"]["li"].all ?? [] {
                if let chapter = Epub3ChapterItem(xmlElement: chapterElement, epubContentsURL: epubContentsURL) {
                    chapters.append(chapter)
                }
            }
        }
        
        return chapters
    }
}
