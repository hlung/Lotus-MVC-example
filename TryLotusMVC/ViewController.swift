//
//  ViewController.swift
//  TryLotusMVC
//
//  Created by Kolyutsakul, Thongchai on 10/9/18.
//  Copyright © 2018 Kolyutsakul, Thongchai. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

  let feedController: FeedController

  lazy var feedViewModel: FeedViewModel = {
    return FeedViewModel(tableView: self.tableView)
  }()

  lazy var tableView: UITableView = {
    return UITableView()
  }()

  init(coordinator: AppCoordinator) {
    self.feedController = FeedController(api: coordinator.api)
    super.init(nibName: nil, bundle: nil)
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

extension FeedViewController: FeedControllerDelegate {
  func feedController(controller: FeedController, isReloading: Bool) {
    // update spinner
  }

  func feedController(controller: FeedController, didFailReloadWith error: Error) {
    // append error cell on top
    feedViewModel.reloadError = error
  }

  func feedController(controller: FeedController, didReload array: [Feed]) {
    // update table
    feedViewModel.reloadError = nil
    feedViewModel.array = array
  }
}
