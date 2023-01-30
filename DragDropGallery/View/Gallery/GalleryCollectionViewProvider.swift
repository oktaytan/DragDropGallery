//
//  GalleryCollectionViewProvider.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import UIKit

protocol GalleryCollectionViewProvider {
    
    var gridType: GridType { get set }
    
    func setData(data: [PhotoResponse])
    func setCollectionView(collectionView: UICollectionView)
    func collectionViewReload()
    func setGridLayout(gridType: GridType)
}

enum GridType {
    case square2x2, square3x3
    
    var icon: UIImage {
        switch self {
        case .square2x2:
            return UIImage(named: "grid_2x2")!.withRenderingMode(.alwaysOriginal)
        case .square3x3:
            return UIImage(named: "grid_3x3")!.withRenderingMode(.alwaysOriginal)
        }
    }
}

class GalleryCollectionViewProviderImpl: NSObject, CollectionViewProvider, GalleryCollectionViewProvider {
    
    typealias T = PhotoResponse
    typealias I = IndexPath
    
    var dataList: [T] = []
    var collectionView: UICollectionView?
    private var innerSpace: CGFloat = 10.0
    private var sideSpace: CGFloat = 10.0
    
    var gridType: GridType = .square2x2 {
        didSet {
            setGridLayout(gridType: self.gridType)
        }
    }
    
    func setData(data: [T]) {
        self.dataList = data
        self.collectionViewReload()
    }
    
    func setCollectionView(collectionView: UICollectionView) {
        
        self.collectionView = collectionView
        self.gridType = .square2x2
        self.collectionView?.register(cellType: GalleryViewCell.self)
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        
        self.collectionView?.dragDelegate = self
        self.collectionView?.dropDelegate = self
        self.collectionView?.dragInteractionEnabled = true
    }
    
    func collectionViewReload() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    fileprivate func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath) {
        if let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath {
            
            self.collectionView?.performBatchUpdates({
                self.dataList.remove(at: sourceIndexPath.item)
                collectionView?.deleteItems(at: [sourceIndexPath])
                self.dataList.insert(item.dragItem.localObject as! PhotoResponse, at: destinationIndexPath.item)
                collectionView?.insertItems(at: [destinationIndexPath])
            })
            
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    func setGridLayout(gridType: GridType) {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = innerSpace
        layout.minimumInteritemSpacing = innerSpace
        layout.sectionInset = UIEdgeInsets(top: innerSpace, left: sideSpace, bottom: innerSpace, right: sideSpace)
        layout.scrollDirection = .vertical
        
        var itemSize: CGFloat
        switch gridType {
        case .square2x2:
            itemSize = (UIScreen.main.bounds.width - (self.sideSpace * 2) - (self.innerSpace)) / 2
        case .square3x3:
            itemSize = (UIScreen.main.bounds.width - (self.sideSpace * 2) - (self.innerSpace * 2)) / 3
        }
        
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        self.collectionView?.collectionViewLayout = layout
    }
}


extension GalleryCollectionViewProviderImpl: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let urlString = self.dataList[indexPath.item].download_url
        let cell = collectionView.dequeueReusableCell(with: GalleryViewCell.self, for: indexPath)
        cell.setupCell(urlString: urlString)
        return cell
    }
}


extension GalleryCollectionViewProviderImpl: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.dataList[indexPath.item]
        let itemProvider = NSItemProvider(object: "\(item.id)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension GalleryCollectionViewProviderImpl: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        var destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let rows = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: rows - 1, section: 0)
        }
        
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath)
        }
    }
}
