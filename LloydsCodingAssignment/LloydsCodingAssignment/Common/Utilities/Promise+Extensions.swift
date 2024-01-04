//
//  Promise+Extensions.swift
//  LloydsCodingAssignment
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//
import Foundation
import UIKit
import PromiseKit

func brokenPromise<T>(method: String = #function) -> Promise<T> {
  return Promise<T>() { seal in
    let err = NSError(domain: "Movies", code: 0, userInfo: [NSLocalizedDescriptionKey: "'\(method)' unexpected input."])
    seal.reject(err)
  }
}

