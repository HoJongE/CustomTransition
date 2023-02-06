//
//  ViewController.swift
//  ViewControllerTesting
//
//  Created by user on 2023/01/31.
//

import UIKit

final class LogButton: UIButton {
}

class ViewController: BaseVC {
    private let button: UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        button.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 100, height: 50))
        button.center = view.center
        button.configuration = .filled()
        button.configuration?.title = "present"
        button.addAction(.init(handler: { [unowned self] _ in
            self.presentTransparentVC()
        }), for: .touchUpInside)
        view.addSubview(button)
        preferredContentSize = CGSize(width: 500, height: 400)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }

    private func presentTransparentVC() {
        let vc = BaseVC(name: "Child")
        vc.view.backgroundColor = .gray
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            vc.dismiss(animated: true)
        }

    }

    override func showDetailViewController(_ vc: UIViewController, sender: Any?) {
        super.showDetailViewController(vc, sender: sender)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        printFunction()
    }
}

class BaseVC: UIViewController {

    let name: String

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }

    convenience init(name: String) {
        self.init(nibName: nil, bundle: nil, name: name)
    }

    required init?(coder: NSCoder) {
        name = "Nones"
        super.init(coder: coder)
    }

    override func loadView() {
        super.loadView()
        printFunction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        printFunction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        printFunction()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printFunction()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        printFunction()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printFunction()
    }

    internal func printFunction(value: String = #function) {
        print("\(name) \(value)")
    }
}
