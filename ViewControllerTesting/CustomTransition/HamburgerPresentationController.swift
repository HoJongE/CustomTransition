//
//  HamburgerPresentationController.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/03.
//

import UIKit

final class HamburgerPresentationController: UIPresentationController {

    private let dimmingView: UIView = .init()

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView else {
            return
        }
        // 1
        dimmingView.frame = containerView.bounds
        dimmingView.backgroundColor = .black.withAlphaComponent(0.7)
        dimmingView.alpha = 0
        // 2
        containerView.addSubview(dimmingView)

        // 3
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 1
        }
        // 4
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDimmingViewClicked(_:))))
    }

    @objc private func onDimmingViewClicked(_ sender: UIView) {
        presentedViewController.dismiss(animated: true)
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
    }
override func dismissalTransitionWillBegin() {
    super.dismissalTransitionWillBegin()
    // 1
    presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.alpha = 0
        }
    }, completion: { context in
        // 2
        guard !context.isCancelled else {
            return
        }
        // 3
        self.dimmingView.removeFromSuperview()
    })
}
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
    }
}
