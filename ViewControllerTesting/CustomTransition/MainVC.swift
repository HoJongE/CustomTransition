//
//  MainVC.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/03.
//

import UIKit

final class MainVC: UIViewController {
    let button: UIButton = .init()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.configuration = .filled()
        button.configuration?.title = "Present new VC"
        button.positionToCenter()
        button.addAction(.init(handler: { [unowned self] _ in
            let newVC = HamburgerVC()
            newVC.modalPresentationStyle = .custom
            newVC.transitioningDelegate = self
            self.present(newVC, animated: true)
        }), for: .touchUpInside)
    }
}


