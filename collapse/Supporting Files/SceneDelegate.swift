//
//  SceneDelegate.swift
//  collapse
//
//  Created by Marc-Antoine BAR on 2023-02-07.
//

import UIKit

/// This class manages the window and lifecycle of the application scene on devices running iOS 13 and later.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        if SettingsRepository.didReadPresentation {
            // swiftlint: disable non_localized_string
            let storyBoardName = "Main"
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "dashboard")
            let window = UIWindow(windowScene: windowScene)
            let navigationController = UINavigationController(rootViewController: initialViewController)
            navigationController.navigationBar.tintColor = UIColor.darkGray
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
        
        // swiftlint: disable unused_optional_binding
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
