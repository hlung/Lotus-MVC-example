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

class ActionController {

  func receive(reaction: Int) {

  }

  func receive(follow: Int) {

  }

}
