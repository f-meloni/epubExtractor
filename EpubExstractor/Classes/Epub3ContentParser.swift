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
    
    init(manifest: [String:ManifestItem], epubContentsURL: URL) {
        let contentFilePath = manifest["toc"]?.href ?? (manifest["htmltoc"]?.href ?? "")
        
        self.contentURL = URL(fileURLWithPath: epubContentsURL.appendingPathComponent(contentFilePath).path)
        let chapters = self.chapters(epubContentsURL: self.contentURL)
        
        print(chapters)
    }
    
    func chapters(epubContentsURL: URL) -> [ChapterItem] {
        guard let contentData = try? Data(contentsOf: self.contentURL),
            let contentDocument = try? AEXMLDocument(xml: contentData) else {
                return []
        }
        
        var chapters: [ChapterItem] = []
        
        if let tocElement = contentDocument.root["body"]["section"]["nav"].all(withAttributes: ["epub:type":"toc"])?.first {
            for chapterElement in tocElement["ol"]["li"].all ?? [] {
                if let chapter = Epub3ChapterItem(xmlElement: chapterElement, epubContentsURL: epubContentsURL) {
                    chapters.append(chapter)
                }
            }
        }
        
        return chapters
    }
}
