//
//  GuideItem.swift
//  Pods
//
//  Created by Franco Meloni on 16/04/2017.
//
//

import UIKit
import AEXML

public struct GuideItem {
    public let title: String?
    public let href: String?
    public let type: String?
    
    public init(xmlElement: AEXMLElement) {
        self.title = xmlElement.attributes["title"]
        self.href = xmlElement.attributes["href"]
        self.type = xmlElement.attributes["type"]
    }
}
