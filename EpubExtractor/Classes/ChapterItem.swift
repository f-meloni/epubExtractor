//
//  ChapterItem.swift
//  Pods
//
//  Created by Franco Meloni on 17/04/2017.
//
//

public protocol ChapterItem {
    var src: URL { get }
    var label: String? { get }
    var subChapters: [ChapterItem] { get }
}
