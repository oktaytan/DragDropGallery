//
//  BaseViewController.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 30.01.2023.
//

import UIKit

enum BarButtonPlace {
    case left, right
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func setBarButtonItem(image: UIImage, place: BarButtonPlace, target: Any?, action: Selector?) {
        let button = UIBarButtonItem(image: image, style: .done, target: target, action: action)
        switch place {
        case .left:
            self.navigationItem.setLeftBarButton(button, animated: true)
        case .right:
            self.navigationItem.setRightBarButton(button, animated: true)
        }
    }
}
