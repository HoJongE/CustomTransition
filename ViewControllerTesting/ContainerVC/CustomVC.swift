//
//  CustomVC.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/02.
//

import UIKit

final class CustomVC: UIViewController {
    private let button: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
    }
}

private extension CustomVC {

    func setUpButton() {
        view.addSubview(button)
        button.configuration = .filled()
        button.configuration?.title = "Go To Second VC"
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.addAction(.init(handler: { [unowned self] _ in
            let secondVC: SecondVC = .init()
            if let parent,
                parent is UIViewControllerTransitioningDelegate {
                secondVC.transitioningDelegate = parent as? UIViewControllerTransitioningDelegate
                secondVC.modalPresentationStyle = .custom
                present(secondVC, animated: true)
                print(secondVC.self)
            } else {
                present(secondVC, animated: true)
            }
        }), for: .touchUpInside )
    }

}

