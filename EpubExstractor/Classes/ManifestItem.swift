//
//  ManifestItem.swift
//  Pods
//
//  Created by Franco Meloni on 16/04/2017.
//
//

import UIKit
import AEXML

public struct ManifestItem {
    public let id: String
    public let href: String?
    public let mediaType: String?
    
    init(id: String, xmlElemet: AEXMLElement) {
        self.id = id
        self.href = xmlElemet.attributes["href"]
        self.mediaType = xmlElemet.attributes["media-type"]
    }
}
