//
//  ModelController.swift
//  TryLotusMVC
//
//  Created by Kolyutsakul, Thongchai on 10/9/18.
//  Copyright © 2018 Kolyutsakul, Thongchai. All rights reserved.
//

import Foundation

protocol FeedControllerDelegate: class {
  func feedController(_ controller: FeedController, isReloading: Bool)
  func feedController(_ controller: FeedController, didFailReloadWith error: Error)

  func feedController(_ controller: FeedController, isLoadingMore: Bool)
  func feedController(_ controller: FeedController, didFailLoadMoreWith error: Error)

  func feedController(_ controller: FeedController, didReload array: [Feed])
}

//protocol ListController {
//  associatedtype Element
//  associatedtype Request
//  associatedtype Response
//
//  var array: [Element] { get set }
//}

/// A model controller for Feed
class FeedController {

  var array: [Feed]
  let firstRequest: FeedRequest
  let nextRequest: FeedRequest? = nil
  let api: APIController
  weak var delegate: FeedControllerDelegate?

  init(api: APIController) {
    self.firstRequest = FeedRequest(type: 1, id: 1, sort: 1, pagination: 1)
    self.array = []
    self.api = api
  }

  func send(reaction: Reaction) {
    // At this point, the UI layer was already updated.
    // What's left to do are...
    // - update array locally
    // - send API request
    // - wait for API failure and undo if needed
    update(with: reaction)

    let request = URLRequest(url: URL(string: "www.myapp.com/feed/123/reaction.json")!)
    self.api.send(request: request) { [weak self] (response) in
      guard let weakSelf = self else { return }

      switch response {
      case .success/*(let data)*/:
        // all went well, nothing more to do because UI was already updated
        break
      case .error/*(let error)*/:
        weakSelf.receive(reaction: reaction.undone)
      }
      weakSelf.delegate?.feedController(weakSelf, isReloading: false)
    }
  }

  func receive(reaction: Reaction) {
    update(with: reaction)
    delegate?.feedController(self, didReload: array)
  }

  func update(with reaction: Reaction) {
    // TODO: Find members in the array corresponding to the reaction, updates it
  }

//  func reloadFromCache() {
//    // load from cache and set to array
//    delegate?.feedController(self, didReload: array)
//  }

  func reload() {
    delegate?.feedController(self, isReloading: true)

    let request = URLRequest(url: URL(string: "www.myapp.com/feed.json")!)
    self.api.send(request: request) { [weak self] (response) in
      guard let weakSelf = self else { return }

      switch response {
      case .success/*(let data)*/:
        let newArray = [Feed]() // TODO: parse data
        weakSelf.array = newArray
        weakSelf.delegate?.feedController(weakSelf, didReload: weakSelf.array)
      case .error(let error):
        weakSelf.delegate?.feedController(weakSelf, didFailReloadWith: error)
      }
      weakSelf.delegate?.feedController(weakSelf, isReloading: false)
    }
  }

  func loadMore() {
    delegate?.feedController(self, isLoadingMore: true)

    let request = URLRequest(url: URL(string: "www.myapp.com/feed.json")!)
    self.api.send(request: request) { [weak self] (response) in
      guard let weakSelf = self else { return }

      switch response {
      case .success/*(let data)*/:
        let newArray = [Feed]() // TODO: parse data
        weakSelf.array.append(contentsOf: newArray)
        weakSelf.delegate?.feedController(weakSelf, didReload: weakSelf.array)
      case .error(let error):
        weakSelf.delegate?.feedController(weakSelf, didFailLoadMoreWith: error)
      }
      weakSelf.delegate?.feedController(weakSelf, isLoadingMore: false)
    }
  }

}
