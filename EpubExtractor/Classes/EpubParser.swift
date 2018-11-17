//
//  EpubParser.swift
//  Pods
//
//  Created by Franco Meloni on 18/02/2017.
//
//

import Foundation
import AEXML

enum EpubParseError: Error {
    case rootFileNotFound
    case rootFileNotValid
    case unknownEpubType
}

final class EpubParser {
    func parseEpub(epubDirectoryURL: URL) throws -> Epub {
        guard let rootFileURL = self.rootFile(epubDirectoryURL: epubDirectoryURL) else {
            throw EpubParseError.rootFileNotFound
        }
        
        guard let data = try? Data(contentsOf: rootFileURL),
            let rootDocument = try? AEXMLDocument(xml: data) else {
                throw EpubParseError.rootFileNotValid
        }
        
        let epubType = self.epubType(rootDocument: rootDocument)
        
        guard epubType != .unknown else {
            throw EpubParseError.unknownEpubType
        }
        
        let contentsURL = rootFileURL.deletingLastPathComponent()
        let metadata = self.epubMetaData(rootDocument: rootDocument)
        let manifest = self.manifest(rootDocument: rootDocument)
        let coverURL = self.ePubCoverURL(rootDocument: rootDocument, manifest: manifest, contentDirectoryURL: contentsURL)
        let guide = self.guide(rootDocument: rootDocument)
        let spine = self.spine(rootDocument: rootDocument, manifest: manifest)
        
        let epubContentParser: EPubContentParser = (epubType == .epub2) ? Epub2ContentParser(manifest: manifest, epubContentsURL: contentsURL) : Epub3ContentParser(manifest: manifest, epubContentsURL: contentsURL)
        
        return Epub(epubDirectoryURL: epubDirectoryURL,
                    type: epubType,
                    coverURL: coverURL,
                    metadata: metadata,
                    manifest: manifest,
                    guide: guide,
                    spine: spine,
                    epubContentParser: epubContentParser)
    }
    
    private func rootFile(epubDirectoryURL: URL) -> URL? {
        let containerURL = URL(fileURLWithPath: epubDirectoryURL.appendingPathComponent("META-INF", isDirectory: true).appendingPathComponent("container.xml").path)
        
        guard let data = try? Data(contentsOf: containerURL),
            let xmlDoc = try? AEXMLDocument(xml:data) else {
            return nil
        }
        
        if let rootFileURLString = xmlDoc.root["rootfiles"].children.first?.attributes["full-path"] {
            return URL(fileURLWithPath: epubDirectoryURL.appendingPathComponent(rootFileURLString).path)
        }
        else {
            return nil
        }
    }
    
    private func epubType(rootDocument: AEXMLDocument) -> EpubType {
        guard let versionString = rootDocument.root.attributes["version"] else {
            return .unknown
        }
        
        switch Float(versionString) {
        case let versionCode where versionCode != nil && versionCode! >= 2.0 && versionCode! < 3.0:
            return .epub2
            
        case let versionCode where versionCode != nil && versionCode! >= 3.0 && versionCode! < 4.0:
            return .epub3
            
        default:
            return .unknown
        }
    }
    
    private func epubMetaData(rootDocument: AEXMLDocument) -> [String:String] {
        let metadataDocument = rootDocument.root["metadata"]
        
        return metadataDocument.children.reduce([:]) { (dictionary, metadata) -> [String:String] in
            var dictionary = dictionary
            dictionary[metadata.name] = (metadata.value ?? "")
            
            return dictionary
        }
    }
    
    private func ePubCoverURL(rootDocument: AEXMLDocument, manifest: [String:ManifestItem], contentDirectoryURL: URL) -> URL? {
        if let coverHref = manifest["cover-image"]?.href {
            return URL(fileURLWithPath: contentDirectoryURL.appendingPathComponent(coverHref).path)
        }
        
        let metaDocument = rootDocument.root["metadata"]
        
        let coverDocumet = metaDocument.children.first(where: { (document) -> Bool in
            return document.attributes["name"] == "cover"
        })
        
        let coverId = coverDocumet?.attributes["content"]
        
        if let coverId = coverId,
            let coverItem = rootDocument.root["manifest"]["item"].all(withAttributes: ["id": coverId])?.first,
            let coverHref = coverItem.attributes["href"] {
            return URL(fileURLWithPath: contentDirectoryURL.appendingPathComponent(coverHref).path)
        }
        
        return nil
    }
    
    private func manifest(rootDocument: AEXMLDocument) -> [String:ManifestItem] {
        let manifestElement = rootDocument.root["manifest"]
        
        return manifestElement.children.reduce([:], { (dictionary, element) -> [String:ManifestItem] in
            if let id = element.attributes["id"] {
                var dictionary = dictionary
                dictionary[id] = ManifestItem(id: id, xmlElemet: element)
                
                return dictionary
            }
            else {
                return dictionary
            }
        })
    }
    
    private func guide(rootDocument: AEXMLDocument) -> [GuideItem] {
        let guideElement = rootDocument.root["guide"]
        
        var result: [GuideItem] = []
        
        for element in guideElement.children {
            result.append(GuideItem(xmlElement: element))
        }
        
        return result
    }
    
    private func spine(rootDocument: AEXMLDocument, manifest: [String: ManifestItem]) -> [SpineItem] {
        let spineElement = rootDocument.root["spine"]
        
        var result: [SpineItem] = []
        
        for element in spineElement.children {
            if let spineItem = SpineItem(xmlElement: element, manifest: manifest) {
               result.append(spineItem)
            }
        }
        
        return result
    }
}
