//
//  HamburgerVC.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/03.
//

import UIKit

final class HamburgerVC: UIViewController {

    let interactiveCoordinator = UIPercentDrivenInteractiveTransition()
    var isInteractionEnable: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        setUpInteractiveCoordinator()
    }

    private func setUpInteractiveCoordinator() {
        let panGestureRecognizer: UIPanGestureRecognizer = .init(target: self, action: #selector(onPan(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        interactiveCoordinator.completionSpeed = 0.5
    }

    @objc private func onPan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view).x
        let percentage: CGFloat = (-translation) / 300
        print(percentage)
        switch sender.state {
        case .began:
            self.isInteractionEnable = true
            self.dismiss(animated: true)
        case .changed:
            guard percentage > 0 else {
                return
            }
            self.interactiveCoordinator.update(percentage)
        default:
            self.isInteractionEnable = false
            if percentage < 0.35 {
                print("cancel")
                self.interactiveCoordinator.cancel()
            } else {
                print("finisjh")
                self.interactiveCoordinator.finish()
            }
        }
    }
}
