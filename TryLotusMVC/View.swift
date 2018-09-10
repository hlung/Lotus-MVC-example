import UIKit

protocol FeedCellDelegate: class {
  func feedCell(_ cell: FeedCell, didReceive reaction: Int)
}

class FeedCell: UITableViewCell {

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("not implemented")
  }
}
