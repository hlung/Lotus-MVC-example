import UIKit

class AppCoordinator {

  let window: UIWindow
  let navigationController: UINavigationController
  let api: APIController
  let actionController: ActionController

  init() {
    api = APIController()
    actionController = ActionController()
    navigationController = UINavigationController(rootViewController: UIViewController())

    window = UIWindow()
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }

  func navigate(to destination: Navigation) {
    switch destination {
    case .feed:
      let viewController = FeedViewController(coordinator: self)
      navigationController.pushViewController(viewController, animated: true)
    }
  }

}

enum Navigation {
  case feed
}
