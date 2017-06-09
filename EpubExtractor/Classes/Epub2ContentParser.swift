//
//  Epub2ContentParser.swift
//  Pods
//
//  Created by Franco Meloni on 16/04/2017.
//
//

import UIKit
import AEXML

struct Epub2ContentParser: EPubContentParser {
    let contentURL: URL
    var chapters: [ChapterItem] = []
    
    init(manifest: [String:ManifestItem], epubContentsURL: URL) {
        let contentFilePath = manifest["ncx"]?.href ?? ""
        
        self.contentURL = URL(fileURLWithPath: epubContentsURL.appendingPathComponent(contentFilePath).path)
        self.chapters = self.parseChapters(epubContentsURL: self.contentURL)
    }
    
    func parseChapters(epubContentsURL: URL) -> [ChapterItem] {
        guard let contentData = try? Data(contentsOf: self.contentURL),
            let contentDocument = try? AEXMLDocument(xml: contentData) else {
                return []
        }
        
        var chapters: [Epub2ChapterItem] = []
        
        for chapterElement in contentDocument.root["navMap"].children {
            if let chapter = Epub2ChapterItem(xmlElement: chapterElement, epubContentsURL: epubContentsURL) {
                chapters.append(chapter)
            }
        }
        
        chapters.sort { $0.playOrder < $1.playOrder }
        
        return chapters
    }
}
