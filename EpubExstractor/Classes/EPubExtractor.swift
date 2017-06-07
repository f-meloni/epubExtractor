//
//  EPubExtractor.swift
//  Pods
//
//  Created by Franco Meloni on 18/02/2017.
//
//

import Foundation

public protocol EpubExtractorDelegate {
    func epubExactorDidExtractEpub(_ epub: Epub)
    func epubExtractorDidFail(error: Error?)
}

public class EPubExtractor {
    private let archiveExtractor: ArchiveExtractor = ArchiveExtractor()
    fileprivate let epubParser: EpubParser = EpubParser()
    
    public var delegate: EpubExtractorDelegate?
    
    public init() {
        self.archiveExtractor.delegate = self
    }
    
    public func extractEpub(epubURL: URL, destinationFolder: URL) {
        self.archiveExtractor.extract(archiveURL: epubURL, destinationFolder: destinationFolder)
    }
}

extension EPubExtractor: ArchiveExtractorDelegate {
    func extractionDidSuccess(epubURL: URL, destinationFolder: URL) {
        do {
            let epub = try self.epubParser.parseEpub(epubDirectoryURL: destinationFolder)
            
            self.delegate?.epubExactorDidExtractEpub(epub)
        }
        catch let error {
            self.delegate?.epubExtractorDidFail(error: error)
        }
    }
    
    func extractionDidFail(error: Error?) {
        self.delegate?.epubExtractorDidFail(error: error)
    }
}
