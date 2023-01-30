//
//  PhotoAPI.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import Foundation

protocol Endpoint {
    var scheme: HTTPScheme { get }
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: [URLQueryItem] { get }
}

enum PhotoAPI: Endpoint {
    case getAlbumPhotos
    
    var scheme: HTTPScheme {
        switch self {
        case .getAlbumPhotos:
            return .https
        }
    }
    
    var baseURL: String {
        switch self {
        case .getAlbumPhotos:
            return "picsum.photos"
        }
    }
    
    var path: String {
        switch self {
        case .getAlbumPhotos:
            return "/v2/list"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAlbumPhotos:
            return .get
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getAlbumPhotos:
            return [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "limit", value: "9"),
                URLQueryItem(name: "seed", value: "true")
            ]
        }
    }
}
