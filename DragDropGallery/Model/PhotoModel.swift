//
//  PhotoModel.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import Foundation

struct PhotoResponse: Decodable, Hashable {
    var id: String
    var author: String
    var width: Double
    var height: Double
    var url: String
    var download_url: String
}
