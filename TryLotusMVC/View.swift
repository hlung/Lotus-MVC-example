import UIKit

protocol FeedCellDelegate: class {
  func feedCell(_ cell: FeedCell, didToggleReaction on: Bool)
}

class FeedCell: UITableViewCell {

  weak var delegate: FeedCellDelegate?

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("not implemented")
  }
}
