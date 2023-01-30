//
//  CollectionViewProvider.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import UIKit

protocol CollectionViewProvider {
    associatedtype T
    associatedtype I
    
    var dataList: [T] { get set }
    func setData(data: [T])
}
