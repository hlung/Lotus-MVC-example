import Foundation

enum APIResponse<T> {
  case success(T)
  case error(Error)
}

//protocol APIRequest {
//  associatedtype Input
//  associatedtype Output
//}

class APIController {
  func send(request: URLRequest, completion: @escaping ((APIResponse<Data>) -> Void)) {
    let urlSession = URLSession()
    let task = urlSession.dataTask(with: request) { (data, response, error) in
      if let data = data {
        completion(.success(data))
      } else {
        // parse error
        completion(.error(error ?? NSError(domain: "com.myapp", code: 0, userInfo: nil)))
      }
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

protocol SessionControllerDelegate: class {
  func sessionControllerDidUpdate(_ controller: SessionController)
}

class SessionController {
  var token: String = "" {
    didSet {
      // save token
    }
  }

  init() {
    // read saved token
  }
}

