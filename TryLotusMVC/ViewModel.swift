import UIKit

protocol FeedTableViewModelDelegate: class {
  func feedTableViewModel(_ viewModel: FeedTableViewModel, didSelect feed: Feed)
  func feedTableViewModel(_ viewModel: FeedTableViewModel, didReceive reaction: Reaction)
}

class FeedTableViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {

  let tableView: UITableView
  weak var delegate: FeedTableViewModelDelegate?

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
    delegate?.feedTableViewModel(self, didSelect: array[indexPath.row])
  }
}

extension FeedTableViewModel: FeedCellDelegate {
  func feedCell(_ cell: FeedCell, didToggleReaction on: Bool) {
    let reaction = Reaction(type: "heart", isOn: on)
    delegate?.feedTableViewModel(self, didReceive: reaction)
  }
}
