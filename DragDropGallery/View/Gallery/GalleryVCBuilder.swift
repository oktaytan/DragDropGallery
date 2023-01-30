//
//  GalleryVCBuilder.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import UIKit

protocol GalleryVCBuilder {
    static func build() -> UIViewController
}

struct GalleryVCBuilderImpl: GalleryVCBuilder {
    static func build() -> UIViewController {
        let vc = GalleryVC(nibName: GalleryVC.className, bundle: nil)
        
        let viewModel = GalleryViewModelImpl()
        let provider = GalleryCollectionViewProviderImpl()
        
        vc.inject(viewModel: viewModel, provider: provider)
        
        return vc
    }
}
