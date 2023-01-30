//
//  APIHelper.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import Foundation

enum HTTPMethod: String {
    case delete = "DELETE"
    case get    = "GET"
    case patch  = "PATCH"
    case post   = "POST"
    case put    = "PUT"
}

enum HTTPScheme: String {
    case http, https
}
