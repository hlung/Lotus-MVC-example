import UIKit

class AppCoordinator {

  let window: UIWindow
  let navigationController: UINavigationController
  let api: APIController
  let actionController: ActionController

  init() {
    api = APIController()
    actionController = ActionController()
    navigationController = UINavigationController()
    window = UIWindow()

    let firstViewController = FeedViewController(coordinator: self)
    navigationController.setViewControllers([firstViewController], animated: false)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }

  func navigate(to destination: Navigation) {
    switch destination {
    case .feedDetail:
      let viewController = FeedDetailViewController(coordinator: self)
      navigationController.pushViewController(viewController, animated: true)
    }
  }

}

enum Navigation {
  case feedDetail(Feed)
}
