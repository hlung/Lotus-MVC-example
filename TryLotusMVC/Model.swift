// Rules for Model
// - Only use VALUE TYPES!!!

import Foundation

struct Feed {
  let id: String
  let title: String
}

protocol Pageable {
  var pagination: Int { get set }
}

struct FeedResponseParameter: Pageable {
  let type: Int
  let id: Int
  let sort: Int
  var pagination: Int
}
