import Foundation

enum Result<T> {
  case success(T)
  case error(Error)
}

protocol APIResponse {
  associatedtype Element
}

//protocol APIRequest {
//  associatedtype Input
//  associatedtype Output
//}

class APIController {
  func send(request: URLRequest, completion: @escaping ((Result<Data?>) -> Void)) {
    let urlSession = URLSession()
    let task = urlSession.dataTask(with: request) { (data, response, error) in
      if let error = error {
        completion(.error(error))
      }

      // TODO: check response code
      // completion(.error(NSError(domain: "com.myapp", code: 0, userInfo: nil)))

      completion(.success(data))
    }
    task.resume()
  }
}

// MARK: -

protocol ActionControllerReactionDelegate: class {
  func actionController(_ controller: ActionController, didUpdate reaction: Reaction)
}

class ActionController {

  // Output
  // TODO: need to multicast (e.g. // pod 'MulticastDelegateSwift')
  // may need multiple delegates because swift protocol func is not optional
  weak var reactionDelegate: ActionControllerReactionDelegate?

  func receive(reaction: Reaction) {
    reactionDelegate?.actionController(self, didUpdate: reaction)
  }

//  func receive(follow: Int) {
//  }

}

// MARK: -

protocol SessionDelegate: class {
  func sessionDidUpdate(_ session: Session)
}

class Session {

  weak var delegate: SessionDelegate? // TODO: can be a multicast delegate

  var token: String = "" {
    didSet {
      // save token, notify of update
    }
  }

  init() {
    // read saved token
  }
}

