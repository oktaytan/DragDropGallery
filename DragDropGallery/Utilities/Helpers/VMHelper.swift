//
//  VMHelper.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import Foundation

enum ObservationType<T, E> {
    case updateUI(data: T? = nil), error(error: E?)
}

protocol ViewModel {
    func start()
}
