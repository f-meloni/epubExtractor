//
//  Epub.swift
//  Pods
//
//  Created by Franco Meloni on 18/02/2017.
//
//

import UIKit

public enum EpubType {
    case unknown
    case epub2
    case epub3
}

public struct Epub {
    public var contentsURL: URL
    public var rootFileURL: URL
    public var type: EpubType
}
