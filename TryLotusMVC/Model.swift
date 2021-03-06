// Rules for Model
// - Only use VALUE TYPES!!!

import Foundation

struct Reaction {
  let type: String
  let isOn: Bool

  var reversed: Reaction {
    return Reaction(type: type, isOn: !isOn)
  }
}

struct Feed {
  let id: String
  let title: String
}

protocol Pageable {
  var pagination: Int { get set }
}

struct FeedRequest: Pageable {
  let type: Int
  let id: Int
  let sort: Int
  var pagination: Int
}

struct PostLikeRequest {
  let id: Int
  let token: String
}

//protocol URLRequestConvertible {
//  var getRequest: URLRequest
//}
