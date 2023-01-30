//
//  GalleryViewModel.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import Foundation

protocol GalleryViewModel: ViewModel {
    
    var state: ((ObservationType< GalleryViewModelImpl.UserInteractivity, Error>) -> Void)? { get set }
    
    func start()
}


class GalleryViewModelImpl: GalleryViewModel {
    
    var state: ((ObservationType<UserInteractivity, Error>) -> Void)?
    
    func start() {
        APIManager.request(endpoint: PhotoAPI.getAlbumPhotos) { [weak self] (result: Result<[PhotoResponse], Error>) in
            switch result {
            case .success(let response):
                self?.state?(.updateUI(data: .updateGalllery(photos: response)))
            case .failure(let error):
                self?.state?(.error(error: error))
            }
        }
    }
}


extension GalleryViewModelImpl {
    enum UserInteractivity {
        case updateGalllery(photos: [PhotoResponse])
    }
}
