//
//  Behaviorally.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import Foundation

protocol MainControllerBehaviorally {
    associatedtype V
    associatedtype P
    func inject(viewModel: V, provider: P)
    func addObservationListener()
    func setupCollectionView()
}
