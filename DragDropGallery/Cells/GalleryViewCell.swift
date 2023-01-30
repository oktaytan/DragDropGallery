//
//  GalleryViewCell.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import UIKit

class GalleryViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.cornerRadius = 12
    }
    
    func setupCell(urlString: String) {
        imageView.loadImageFromUrl(urlString: urlString, placeholder: nil)
    }

}
