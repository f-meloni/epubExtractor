//
//  EPubContentParser.swift
//  Pods
//
//  Created by Franco Meloni on 16/04/2017.
//
//

import UIKit

protocol EpubContentParser {
    var contentURL: URL { get }
    var parentURL: URL { get }
    var chapters: [ChapterItem] { get }
    var manifest: [String: ManifestItem] { get }
    
    func content(forSpine: SpineItem) throws -> NSAttributedString
    func content(forSpine: SpineItem) throws -> String
}

extension EpubContentParser {
    func content(forSpine: SpineItem) throws -> NSAttributedString {
        if let url = manifest[forSpine.idRef]?.href {
            let data = try Data(contentsOf: URL(fileURLWithPath: parentURL.appendingPathComponent(url).path))
            let mutable = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            return mutable
        }
        throw NSError(domain: "epub.extractor", code: 1, userInfo: ["localizedDescription": "Could not load file"])
    }
    
    func content(forSpine: SpineItem) throws -> String {
        return try content(forSpine: forSpine).string
    }
}
