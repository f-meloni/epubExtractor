//
//  ArchiveExtractor.swift
//  Pods
//
//  Created by Franco Meloni on 18/02/2017.
//
//

import UIKit
import SSZipArchive

protocol ArchiveExtractorDelegate {
    func extractionDidSuccess(epubURL: URL, destinationFolder: URL)
    func extractionDidFail(error: Error?)
}

final class ArchiveExtractor {
    var delegate: ArchiveExtractorDelegate? = nil
    
    func extract(archiveURL: URL, destinationFolder: URL) {
        SSZipArchive.unzipFile(atPath: archiveURL.path, toDestination: destinationFolder.path, progressHandler: { (_, _, _, _) in }) { (_, didSuccess, error) in
            if didSuccess {
                self.delegate?.extractionDidSuccess(epubURL: archiveURL, destinationFolder: destinationFolder)
            }
            else {
                self.delegate?.extractionDidFail(error: error)
            }
        }
    }
}
