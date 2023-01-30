//
//  SceneDelegate.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let galleryVC = GalleryVCBuilderImpl.build()
        let nav = UINavigationController(rootViewController: galleryVC)
        window.rootViewController = nav
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

