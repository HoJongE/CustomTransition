//
//  CustomContainerVC.swift
//  ViewControllerTesting
//
//  Created by user on 2023/02/01.
//

import UIKit

class VerticalDoubleVC: UIViewController {

    private let topIndicator: UILabel = .init()
    private let bottomIndicator: UILabel = .init()
    private let convertButton: UIButton = .init()
    private var isInitiated: Bool = false
    private lazy var topFrame: CGRect = {
        CGRect(origin: CGPoint(x: 0, y: topIndicator.frame.maxY), size: CGSize(width: view.frame.width, height: bottomIndicator.frame.minY - topIndicator.frame.maxY))
    }()
    private lazy var bottomFrame: CGRect = {
        CGRect(origin: CGPoint(x: 0, y: bottomIndicator.frame.maxY), size: CGSize(width: view.frame.width, height: view.safeAreaLayoutGuide.layoutFrame.maxY - bottomIndicator.frame.maxY))
    }()

    var animator: Animator?

    enum Position {
        case top
        case bottom
    }

    func frame(of position: Position) -> CGRect {
        switch position {
        case .bottom:
            return bottomFrame
        case .top:
            return topFrame
        }
    }

    func position(of vc: UIViewController) -> Position? {
        if vc === topVC {
            return .top
        } else if vc === bottomVC {
            return .bottom
        }
        return nil
    }

    func view(for position: Position) -> UIView? {
        switch position {
        case .top:
            return topVC?.view
        case .bottom:
            return bottomVC?.view
        }
    }

    public var topVC: UIViewController? {
        didSet {
            guard let topVC else {
                topIndicator.text = "None"
                return
            }
            topIndicator.text = "\(topVC)"
        }
    }

    public var bottomVC: UIViewController? {
        didSet {
            guard let bottomVC else {
                bottomIndicator.text = "None"
                return
            }
            bottomIndicator.text = "\(bottomVC)"
        }
    }

    init(
        topVC: UIViewController? = nil,
        bottomVC: UIViewController? = nil
    ) {
        self.topVC = topVC
        self.bottomVC = bottomVC
        super.init(nibName: nil, bundle: nil)
        setUpIndicator()
        if let topVC {
            setChildVC(topVC, .top)
            topIndicator.text = "\(topVC)"
        }
        if let bottomVC {
            setChildVC(bottomVC, .bottom)
            bottomIndicator.text = "\(bottomVC)"
        }
        setUpConvertButton()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isInitiated {
            isInitiated = true
            topVC?.view.frame = topFrame
            bottomVC?.view.frame = bottomFrame
        }
    }

}
// MARK: - ??????????????? ??????
private extension VerticalDoubleVC {

    func setUpIndicator() {
        view.addSubview(topIndicator)
        view.addSubview(bottomIndicator)
        topIndicator.text = topVC?.title ?? "None"
        bottomIndicator.text = bottomVC?.title ?? "None"
        topIndicator.backgroundColor = .white
        bottomIndicator.backgroundColor = .white
        topIndicator.translatesAutoresizingMaskIntoConstraints = false
        bottomIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topIndicator.leftAnchor.constraint(equalTo: view.leftAnchor),
            topIndicator.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomIndicator.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomIndicator.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomIndicator.topAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func setUpConvertButton() {
        view.addSubview(convertButton)
        convertButton.translatesAutoresizingMaskIntoConstraints = false
        convertButton.configuration = .filled()
        convertButton.configuration?.image = UIImage(systemName: "arrow.up.arrow.down")
        convertButton.configuration?.imagePlacement = .all
        convertButton.addAction(.init(handler: { [unowned self] _ in
            self.convertPosition()
        }), for: .touchUpInside)
        NSLayoutConstraint.activate([
            convertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            convertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

// MARK: - function
private extension VerticalDoubleVC {
    func convertPosition() {
        // ???????????? ??????
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: [
                .transitionCrossDissolve,
                .curveEaseInOut
            ]
        ) { [topVC, bottomVC, self] in
            self.topVC?.view.frame = bottomFrame
            self.bottomVC?.view.frame = topFrame
            let temp = bottomVC
            self.bottomVC = topVC
            self.topVC = temp
        }
    }
}

// MARK: - Child ?????? ??????
private extension VerticalDoubleVC {

    private func removeChildVC(_ position: Position) {
        let vcToRemove: UIViewController?
        switch position {
        case .top:
            vcToRemove = topVC
        case .bottom:
            vcToRemove = bottomVC
        }

        guard let vcToRemove else {
            return
        }

        // 1. Child ????????? willMove ???????????? ??????
        vcToRemove.willMove(toParent: nil)
        // 2. ??????????????? ???????????? (?????? ?????? ?????? ?????? ??????)
        vcToRemove.view.removeConstraints(vcToRemove.view.constraints)
        // 3. removeFromSuperView??? ??? ??????
        vcToRemove.view.removeFromSuperview()
        // 4. removeFromParent ??????
        vcToRemove.removeFromParent()
    }

    private func setChildVC(
        _ child: UIViewController,
        _ position: Position
    ) {
        // 1. addChild ????????? ??????
        addChild(child)
        // 2. child ????????? View??? ??? ??????????????? ??????
        view.insertSubview(child.view, at: 0)
        // 3. child ????????? View??? size??? position??? ??????
        // 4. child ???????????? transition ????????? ??????
        child.didMove(toParent: self)

        print(children)
    }
}
