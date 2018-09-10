import UIKit

protocol FeedViewModelDelegate: class {
  func feedViewModel(_ viewModel: FeedViewModel, didSelect feed: Feed)
  func feedViewModel(_ viewModel: FeedViewModel, didReceive reaction: Reaction)
}

class FeedViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {

  let tableView: UITableView
  weak var delegate: FeedViewModelDelegate?

  init(tableView: UITableView) {
    self.tableView = tableView
    super.init()
    tableView.register(FeedCell.self, forCellReuseIdentifier: "cell")
    // TODO: register loading, error, and other types of cell
    tableView.dataSource = self
    tableView.delegate = self
  }

  var array: [Feed] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  var reloadError: Error? = nil {
    didSet {
      // TODO: append error cell at top
    }
  }

  var loadMoreError: Error? = nil {
    didSet {
      // TODO: append error cell at bottom
    }
  }

  var isLoadingMore: Bool = false {
    didSet {
      // TODO: append loading cell at bottom
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
    cell.delegate = self
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.feedViewModel(self, didSelect: array[indexPath.row])
  }
}

extension FeedViewModel: FeedCellDelegate {
  func feedCell(_ cell: FeedCell, didToggleReaction on: Bool) {
    let reaction = Reaction(type: "heart", isOn: on)
    delegate?.feedViewModel(self, didReceive: reaction)
  }
}
