import UIKit

class AppCoordinator {

  let window: UIWindow
  let navigationController: UINavigationController
  let api: APIController
  let session: Session
  let actionController: ActionController

  init() {
    api = APIController()
    actionController = ActionController()
    navigationController = UINavigationController()
    window = UIWindow()
    session = Session()
    session.delegate = self

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

extension AppCoordinator: SessionDelegate {
  func sessionDidUpdate(_ session: Session) {
    // do stuff
  }
}

enum Navigation {
  case feedDetail(Feed)
}
