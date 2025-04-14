//
//  SceneDelegate.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-12.
//
//  This class manages the scene lifecycle for the SwiftBites application.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    /// The window associated with the scene
    var window: UIWindow?

    /// Called when a new scene session is being created
    /// - Parameters:
    ///   - scene: The scene that's being connected
    ///   - session: The session for the scene
    ///   - connectionOptions: Options for configuring the connection
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    /// Called when a scene is being released by the system
    /// - Parameter scene: The scene that's being disconnected
    func sceneDidDisconnect(_ scene: UIScene) {
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded.
    }

    /// Called when the scene has moved from an inactive state to an active state
    /// - Parameter scene: The scene that became active
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    /// Called when the scene will move from an active state to an inactive state
    /// - Parameter scene: The scene that will resign active
    func sceneWillResignActive(_ scene: UIScene) {
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    /// Called as the scene transitions from the background to the foreground
    /// - Parameter scene: The scene entering the foreground
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Use this method to undo the changes made on entering the background.
    }

    /// Called as the scene transitions from the foreground to the background
    /// - Parameter scene: The scene entering the background
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Use this method to save data, release shared resources, and store scene-specific state information.
    }
}

