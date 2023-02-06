//
//  SecondVC.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/02.
//

import UIKit

final class SecondVC: UIViewController {

    let button: UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        button.configuration = .filled()
        button.configuration?.title = "Close"
        button.addAction(.init(handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }), for: .touchUpInside)
    }
}
