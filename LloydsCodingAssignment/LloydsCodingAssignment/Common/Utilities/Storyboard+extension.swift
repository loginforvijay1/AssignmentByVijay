//
//  Storyboard+extension.swift
//  LloydsCodingAssignment
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
}

protocol StoryboardBased {
    static var storyboard: Storyboard { get }
    static func instantiate() -> Self
}

extension StoryboardBased where Self: UIViewController {
    static func instantiate() -> Self {
        guard let viewController = UIStoryboard(storyboard).instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self else {
            fatalError("No view controller in storyboard")
        }

        return viewController
    }
}

extension UIStoryboard {
    convenience init(_ storyboard: Storyboard) {
        self.init(name: storyboard.rawValue, bundle: nil)
    }
}


