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
    public let contentsURL: URL
    public let rootFileURL: URL
    public let type: EpubType
    public let coverURL: URL?
    public let metadata: [String:String]
    public let manifest: [String:ManifestItem]
    
    public var title: String? {
        get {
            return self.metadata[titleKey]
        }
    }
    
    public var author: String? {
        get {
            return self.metadata[authorKey]
        }
    }
    
    public var language: String? {
        get {
            return self.metadata[languageKey]
        }
    }
    
    public var publisher: String?{
        get {
            return self.metadata[publisherKey]
        }
    }
    
    public var identifier: String?{
        get {
            return self.metadata[publisherKey]
        }
    }
}
