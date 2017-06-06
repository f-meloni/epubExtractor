//
//  SpineItem.swift
//  Pods
//
//  Created by Franco Meloni on 16/04/2017.
//
//

import UIKit
import AEXML

struct SpineItem {
    public let idRef: String
    public let linear: Bool
    
    init?(xmlElement: AEXMLElement) {
        guard let idRef = xmlElement.attributes["idref"] else {
            return nil
        }
        
        self.idRef = idRef
        self.linear = xmlElement.attributes["linear"]?.caseInsensitiveCompare("yes") == .orderedSame
    }
}
