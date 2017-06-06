//
//  EPubContentParser.swift
//  Pods
//
//  Created by Franco Meloni on 16/04/2017.
//
//

import UIKit

protocol EPubContentParser {
    var contentURL: URL { get }
    func chapters(epubContentsURL: URL) -> [ChapterItem]
}
