//
//  HamburgerAnimator.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/03.
//

import UIKit

final class HamburgerAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private static let duration: TimeInterval = 0.3
    private let isPresenting: Bool

    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animatePresenting(using: transitionContext)
            return
        }
        animateDismiss(using: transitionContext)
    }

    

    func animatePresenting(using transitionContext: UIViewControllerContextTransitioning) {
        // 1
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        // 2
        let containerView: UIView = transitionContext.containerView
        // 3
        let targetFrame = containerView.bounds.applying(CGAffineTransform(scaleX: 0.8, y: 1))
        // 4
        toView.frame = targetFrame.applying(CGAffineTransform(translationX: -targetFrame.width, y: 0))
        // 5
        containerView.addSubview(toView)

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [
                .curveEaseInOut
            ]) {
                // 6
                toView.frame = targetFrame
            } completion: { result in
                // 7
                transitionContext.completeTransition(result)
            }
    }

    func animateDismiss(using transitionContext: UIViewControllerContextTransitioning) {

        // 1
        guard let dismissedView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        // 2
        let targetFrame = dismissedView.frame.applying(CGAffineTransform(translationX: -dismissedView.frame.width, y: 0))

        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [
                .curveEaseInOut
            ]
        ) {
            dismissedView.frame = targetFrame
        } completion: { result in
            guard !transitionContext.transitionWasCancelled else {
                transitionContext.completeTransition(false)
                return
            }
            dismissedView.removeFromSuperview()
            transitionContext.completeTransition(result)
        }
    }
}
