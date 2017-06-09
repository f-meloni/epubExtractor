//
//  Epub.swift
//  Pods
//
//  Created by Franco Meloni on 18/02/2017.
//
//

import UIKit

private let titleKey = "dc:title"
private let authorKey = "dc:creator"
private let languageKey = "dc:language"
private let publisherKey = "dc:publisher"
private let identifierKey = "dc:identifier"

public enum EpubType {
    case unknown
    case epub2
    case epub3
}

public struct Epub {
    /**
     The URL of the folder that contains all the Epub data
     */
    public let epubDirectoryURL: URL
    /**
     The type of the ePub
    */
    public let type: EpubType
    /**
     URL to the Epub's cover image
     */
    public let coverURL: URL?
    /**
     the Epub's parsed metadata
     */
    public let metadata: [String:String]
    /**
     the Epub's parsed manifest
     */
    public let manifest: [String:ManifestItem]
    /**
     the Epub's parsed guide
     */
    public let guide: [GuideItem]
    /**
     the Epub's parsed spine 
     *Warning:* this array contains the list of file that you should use to setup your Epub reader
     */
    public let spine: [SpineItem]
    
    let epubContentParser: EPubContentParser
    
    /**
     Epub's title
    */
    public var title: String? {
        get {
            return self.metadata[titleKey]
        }
    }
    /**
     Epub's author
     */
    public var author: String? {
        get {
            return self.metadata[authorKey]
        }
    }
    
    /**
     Epub's language
     */
    public var language: String? {
        get {
            return self.metadata[languageKey]
        }
    }
    
    /**
     Epub's publisher
     */
    public var publisher: String?{
        get {
            return self.metadata[publisherKey]
        }
    }
    
    /**
     Epub's identifier
     */
    public var identifier: String?{
        get {
            return self.metadata[publisherKey]
        }
    }
    
    /**
     List of chapter and subchapters rappresenting the Epub's table of contents
    */
    public var chapters: [ChapterItem] {
        return self.epubContentParser.chapters
    }
}
