//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by XXX on 25.05.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  private var appCoordinator: AppCoordinator?
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: scene)
    self.window = window
    DIContainer.shared.assembler.apply(assembly: AppAssembly())
    appCoordinator = DIContainer.shared.resolve(argument: window)
    appCoordinator?.start()
  }
}
