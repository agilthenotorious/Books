//
//  ApiResponse.swift
//  Design Patterns
//
//  Created by Agil Madinali on 9/22/20.
//

import Foundation

struct ApiResponse: Decodable {
    var bookKind: String?
    var totalItems: Int?
    var items: [ItemInfo]?
    
    enum CodingKeys: String, CodingKey {
        case bookKind = "kind"
        case totalItems
        case items
    }
}

struct ItemInfo: Decodable {
    var itemKind: String?
    var itemId: String?
    var eTag: String?
    var selfLink: String?
    var volumeInfo: VolumeInfo?
    var accessInfo: AccessInfo?
    
    enum CodingKeys: String, CodingKey {
        case itemKind = "kind"
        case itemId = "id"
        case eTag = "etag"
        case selfLink
        case volumeInfo
        case accessInfo
    }
}

struct VolumeInfo: Decodable {
    var title: String?
    var subTitle: String?
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var description: String?
    var pageCount: Int?
    var imageLinks: ImageLinks?
    var previewLink: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "subtitle"
        case authors
        case publisher
        case publishedDate
        case description
        case pageCount
        case imageLinks
        case previewLink
    }
}

struct ImageLinks: Decodable {
    var smallThumbnail: String?
    var thumbnail: String?
}

struct AccessInfo: Decodable {
    var pdfIndo: PdfInfo?
    var webReaderLink: String?
    
    enum CodingKeys: String, CodingKey {
        case pdfIndo = "pdf"
        case webReaderLink
    }
}

struct PdfInfo: Decodable {
    var acsTokenLink: String?
}
