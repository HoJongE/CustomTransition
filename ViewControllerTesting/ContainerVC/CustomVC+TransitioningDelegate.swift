//
//  CustomVC+TransitioningDelegate.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/02.
//

import UIKit

extension VerticalDoubleVC: UIViewControllerTransitioningDelegate {

    // MARK: - 뷰컨을 해제할 때!
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animate disappear")
        guard let secondVC = dismissed as? SecondVC
        else { return nil }
        animator = Animator(
            .dismiss,
            first: self,
            second: secondVC,
            position: nil
        )
        return animator
    }

    // MARK: - 새로운 뷰컨을 보여줄 때!
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animate appear")
        guard let firstVC = presenting as? VerticalDoubleVC,
              let position = firstVC.position(of: source)
        else { return nil }
        animator = Animator(.present, first: firstVC, second: presented, position: position)
        return animator
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        print("prepare presentation controller")
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }

}
