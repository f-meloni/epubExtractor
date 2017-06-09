//
//  SpineItem.swift
//  Pods
//
//  Created by Franco Meloni on 16/04/2017.
//
//

import UIKit
import AEXML

public struct SpineItem {
    public let idRef: String
    public let linear: Bool
    public let href: String?
    
    init?(xmlElement: AEXMLElement, manifest: [String:ManifestItem]) {
        guard let idRef = xmlElement.attributes["idref"] else {
            return nil
        }
        
        self.idRef = idRef
        self.linear = xmlElement.attributes["linear"]?.caseInsensitiveCompare("yes") == .orderedSame
        self.href = manifest[idRef]?.href
    }
}
