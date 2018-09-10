//
//  ViewController.swift
//  TryLotusMVC
//
//  Created by Kolyutsakul, Thongchai on 10/9/18.
//  Copyright © 2018 Kolyutsakul, Thongchai. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

  let coordinator: AppCoordinator
  let feedController: FeedController

  lazy var feedViewModel: FeedViewModel = {
    return FeedViewModel(tableView: self.tableView)
  }()

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    return tableView
  }()

  init(coordinator: AppCoordinator) {
    self.coordinator = coordinator
    self.feedController = FeedController(api: coordinator.api)
    super.init(nibName: nil, bundle: nil)
    //coordinator.actionController.reactionDelegate += self
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    feedController.reload()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension FeedViewController: FeedViewModelDelegate {
  func feedViewModel(_ viewModel: FeedViewModel, didSelect feed: Feed) {
    coordinator.navigate(to: Navigation.feedDetail(feed))
  }

  func feedViewModel(_ viewModel: FeedViewModel, didReceive reaction: Reaction) {
    feedController.send(reaction: reaction)
  }
}

extension FeedViewController: FeedControllerDelegate {
  func feedController(_ controller: FeedController, isReloading: Bool) {
    // update activity indicator
  }

  func feedController(_ controller: FeedController, didFailReloadWith error: Error) {
    feedViewModel.reloadError = error
  }

  func feedController(_ controller: FeedController, isLoadingMore: Bool) {
    feedViewModel.isLoadingMore = isLoadingMore
  }

  func feedController(_ controller: FeedController, didFailLoadMoreWith error: Error) {
    feedViewModel.loadMoreError = error
  }

  func feedController(_ controller: FeedController, didReload array: [Feed]) {
    // update table
    feedViewModel.reloadError = nil
    feedViewModel.array = array
  }
}

extension FeedViewController: ActionControllerReactionDelegate {
  func actionController(_ controller: ActionController, didUpdate reaction: Reaction) {
    feedController.receive(reaction: reaction)
  }
}


class FeedDetailViewController: UIViewController {

  let coordinator: AppCoordinator

  init(coordinator: AppCoordinator) {
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
