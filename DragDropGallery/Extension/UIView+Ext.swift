//
//  UIView+Ext.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 30.01.2023.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
}
