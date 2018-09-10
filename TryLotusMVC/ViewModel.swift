import UIKit

class FeedViewModel: NSObject, UITableViewDataSource {

  let tableView: UITableView

  init(tableView: UITableView) {
    self.tableView = tableView
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }

  var array: [Feed] = [] {
    didSet {
      tableView.reloadData()
    }
  }

  var reloadError: Error? = nil {
    didSet {
      tableView.reloadData()
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
  }

}
