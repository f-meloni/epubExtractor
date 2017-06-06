//
//  EPubExtractor.swift
//  Pods
//
//  Created by Franco Meloni on 18/02/2017.
//
//

import Foundation

public class EPubExtractor {
    private let archiveExtractor: ArchiveExtractor = ArchiveExtractor()
    fileprivate let epubParser: EpubParser = EpubParser()
    
    public init() {
        self.archiveExtractor.delegate = self
    }
    
    public func extractEpub(epubURL: URL, destinationFolder: URL) {
        self.archiveExtractor.extract(archiveURL: epubURL, destinationFolder: destinationFolder)
    }
}

extension EPubExtractor: ArchiveExtractorDelegate {

    func extractionDidSuccess(epubURL: URL, destinationFolder: URL) {
        self.epubParser.parseEpub(epubDirectoryURL: destinationFolder)
    }
    
    func extractionDidFail(error: Error?) {
        
    }
}
