//
//  SceneDelegate.swift
//  StandaloneSciChart
//
//  Created by Sanjeev Bharti on 6/9/20.
//  Copyright © 2020 Sanjeev Bharti. All rights reserved.
//

import UIKit
import SciChart

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }

        SCIChartSurface.setRuntimeLicenseKey("TKhvjJzf48ymvt/Ts8sJjIR8potBDRWEa/wl7etNtabnRoVAS6BchiNtVb322kv/PFlEXYMBs+n3GoMgZl99vfQRww8UKAUj1idzRdT8i7JjY3IojlOJkuqP797EGnW2a6DkIAR9zTnH1DGcjcp5XLkYgLYkd0e1sw9ZRHkzNUVXGOMD7EiDHBoLYPuX2LBgxOKzhsVdAE8CLlkHMWXiPR+xELgQvI9+Rhk+f7Bp4L5fqXA2kG0/yTyLf3wDSNrls0QrEdy6MLxmnS9I/aQhGO1QOfh6steZSqWy4FgGgXABrK9kzOqAocKNMlbu125juhIgFoSVRx2viDGCwiGp++x3NINgUJGS9yM4NC367IgQgniS38Y7Iu1nPoc/OCvQsROTSsbXuPBIHIEqZ4f/vDPFYZd1REUYKX3wG1WEHJ+1X14BDH7zY9JmjYTG5SxDL1FwkxzT/pGybSmMQtuJiv6+5PHBubseTm7lHnYT27p41q5Kht8NGYRp4kTu4rjYQl3/Fc9ydRPsjB4brl5dTB0d0PjXyZ0gsfqUSLSBlIp9hRhkXiMXOKTU8k8srwW06DE=")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

