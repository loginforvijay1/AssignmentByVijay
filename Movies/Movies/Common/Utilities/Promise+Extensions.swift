

import Foundation
import UIKit
import PromiseKit

func brokenPromise<T>(method: String = #function) -> Promise<T> {
  return Promise<T>() { seal in
    let err = NSError(domain: "Movies", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' unexpected input."])
    seal.reject(err)
  }
}
