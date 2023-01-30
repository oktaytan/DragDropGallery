//
//  GalleryVC.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import UIKit

class GalleryVC: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias V = GalleryViewModel
    typealias P = GalleryCollectionViewProvider
    
    private var provider: P!
    var viewModel: V!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addObservationListener()
        setupCollectionView()
        self.viewModel.start()
    }
    
    private func setupView() {
        self.title = "Gallery"
        self.setBarButtonItem(image: GridType.square3x3.icon, place: .right, target: self, action: #selector(changeGalleryLayout))
    }
}


extension GalleryVC: MainControllerBehaviorally {
    func inject(viewModel: V, provider: P) {
        self.viewModel = viewModel
        self.provider = provider
    }
    
    func setupCollectionView() {
        provider.setCollectionView(collectionView: collectionView)
    }
    
    func addObservationListener() {
        viewModel.state = { [weak self] type in
            switch type {
            case .updateUI(let data):
                self?.handleStateData(data: data)
            case .error(let error):
                self?.handleError(message: error?.localizedDescription)
            }
        }
    }
    
    private func handleStateData(data: GalleryViewModelImpl.UserInteractivity?) {
        switch data {
        case .updateGalllery(let photos):
            self.provider.setData(data: photos)
        default:
            break
        }
    }
    
    private func handleError(message: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: nil, message: message)
        }
    }
    
    @objc func changeGalleryLayout() {
        self.provider.gridType = self.provider.gridType == .square2x2 ? .square3x3 : .square2x2
        self.navigationItem.rightBarButtonItem?.image = self.provider.gridType == .square2x2 ? GridType.square3x3.icon : GridType.square2x2.icon
    }
}
