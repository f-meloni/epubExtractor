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
        var contentFileRelativePath = ""
        
        if let toc = manifest["toc"]?.href {
            contentFileRelativePath = toc
        } else if let toc = manifest["htmltoc"]?.href {
            contentFileRelativePath = toc
        } else if let toc = manifest["nav"]?.href {
            contentFileRelativePath = toc
        }
        
        let contentFilePath = epubContentsURL.appendingPathComponent(contentFileRelativePath, isDirectory: true).path
        self.contentURL = URL(fileURLWithPath: contentFilePath)
        self.chapters = self.parseChapters(epubContentsURL: epubContentsURL)
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
