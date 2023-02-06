//
//  Animator.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/02.
//

import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    private static let duration: TimeInterval = 1.25
    private let firstVC: VerticalDoubleVC
    private let secondVC: UIViewController
    private let type: PresentationType
    private let position: VerticalDoubleVC.Position?

    init?(
        _ type: PresentationType,
        first firstVC: VerticalDoubleVC,
        second secondVC: UIViewController,
        position: VerticalDoubleVC.Position? = nil
    ) {

        guard let window = firstVC.view.window else {
            return nil
        }
        self.position = position
        self.type = type
        self.firstVC = firstVC
        self.secondVC = secondVC
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .present:
            appear(transitionContext: transitionContext)
        case .dismiss:
            dismiss(context: transitionContext)
        }
    }

    func appear(
        transitionContext: UIViewControllerContextTransitioning
    ) {
        let containerView = transitionContext.containerView
        guard let toView = secondVC.view,
              let position
        else {
            transitionContext.completeTransition(false)
            return
        }
        toView.frame = .zero
        toView.alpha = 0.3
        containerView.addSubview(toView)
        print(containerView.frame)

        UIView.animate(withDuration: 0.5, delay: 0, options: [
            .curveEaseInOut
        ]) {
            toView.transform = .identity
            toView.alpha = 1
            toView.frame = containerView.bounds
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }

    func dismiss(context: UIViewControllerContextTransitioning) {
        guard let fromView = secondVC.view
        else {
            context.completeTransition(false)
            return
        }
        UIView.animate(withDuration: 0.4, delay: 0) {
            fromView.alpha = 0
            fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        } completion: { _ in
            context.completeTransition(true)
        }
    }

    enum PresentationType {
        case present
        case dismiss

        var isPresenting: Bool {
            self == .present
        }
    }
}

final class CustomPresentationController: UIPresentationController {

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.frame = CGRect(origin: CGPoint(x: 100, y: 300), size: CGSize(width: 100, height: 100))
        print("will begin transition")
        let dimmingView: UIView = UIView(frame: containerView?.bounds ?? .zero)
        dimmingView.backgroundColor = .black.withAlphaComponent(0.7)
        containerView?.addSubview(dimmingView)
        print(containerView.self)
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        print("did end transition")
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
    }

}
