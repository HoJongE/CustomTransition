//
//  UIView+Constraint.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/03.
//

import UIKit

public extension UIView {
    func positionToCenter() {
        guard let superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
}
