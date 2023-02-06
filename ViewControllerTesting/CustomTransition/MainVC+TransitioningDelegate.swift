//
//  MainVC+TransitioningDelegate.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/03.
//

import UIKit

extension MainVC: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard presented is HamburgerVC else {
            return nil
        }
        return HamburgerAnimator(isPresenting: true)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard dismissed is HamburgerVC else {
            return nil
        }
        return HamburgerAnimator(isPresenting: false)
    }

func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    guard let vc = presentedViewController as? HamburgerVC else {
        return nil
    }
    return vc.isInteractionEnable ? vc.interactiveCoordinator : nil
}

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard presented is HamburgerVC else {
            return nil
        }
        return HamburgerPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
