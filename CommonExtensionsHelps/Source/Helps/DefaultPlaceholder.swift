//
//  DefaultPlaceholder.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/28.
//  Copyright © 2020 Hy. All rights reserved.
//

import UIKit
import SnapKit

open class DefaultPlaceholder: UIView {
    public typealias CustomizeClosure = (DefaultPlaceholder.Context, PlaceholderState) -> Void
    public typealias RetryClosure = (DefaultPlaceholder.Context ,Placeholdersble) -> Void
    public typealias OtherClosure = RetryClosure
    
/// public propertys
    public var isLoading: Bool = false
    public var state: PlaceholderState = .none
    
    public lazy var indicatorView: InstagramActivityIndicator = InstagramActivityIndicator()
    public lazy var imageView: UIImageView = UIImageView()
    public lazy var titleLabel: UILabel = UILabel()
    public lazy var subtitleLabel: UILabel = UILabel()
    public lazy var button: TryButton = TryButton()
    
/// private propertys
    private var retryClosure: RetryClosure?
    private var otherClosure: OtherClosure?
    private var customizeClosure: CustomizeClosure?
    private var stackView = UIStackView()
    private lazy var _subviews: [UIView] = [indicatorView, imageView, titleLabel, button]
    private var _context: Context {
        Context(indicatorView: indicatorView,
        imageView: imageView,
        titleLabel: titleLabel,
        subtitleLabel: subtitleLabel,
        button: button)
    }
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    public func customize(_ Closure: @escaping CustomizeClosure) {
        self.customizeClosure = Closure
    }
    
    public func retry(_ Closure: @escaping RetryClosure) {
        retryClosure = Closure
    }
    
    public func otherClosure(_ Closure: @escaping OtherClosure) {
        otherClosure = Closure
    }
    
    private func initialize() {
        indicatorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(indicatorView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(button)
        _subviews.forEach{$0.isHidden = true}
        defaultStyle()
    }
    
    private func defaultStyle() {
        backgroundColor = .white
        
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10

        indicatorView.strokeColor = UIColor.gray
        
        titleLabel.textColor = .darkText
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        titleLabel.textAlignment = .center
        
        subtitleLabel.textColor = .gray
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 3
        
        button.backgroundColor = .black
        button.label.textColor = .white
        button.label.font = UIFont.boldSystemFont(ofSize: 17)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(pressesAction), for: .touchUpInside)
    }
    
    @objc private func pressesAction() {
        if case .error(_) = state {
            retryClosure?(_context, self)
        } else {
            otherClosure?(_context, self)
        }
    }
    
    public func show() {
        if self.isHidden {
            self.isHidden = false
        }
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0
        }) { _ in
            self.isHidden = true
        }
    }
    
}

extension DefaultPlaceholder: Placeholdersble {
    
    public func onState(_ state: PlaceholderState) {
        _subviews.forEach{$0.isHidden = true}
        self.processState(state)
        UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.customizeClosure?(self._context, state)
        }, completion: nil)
    }
    
    private func processState(_ state: PlaceholderState) {
        self.state = state
        switch state {
        case .none:
            hide()
            indicatorView.stopAnimating()
        case .loading:
            show()
            indicatorView.isHidden = false
            titleLabel.isHidden = false
            subtitleLabel.isHidden = false
            button.isHidden = false
            indicatorView.startAnimating()
        case .error:
            show()
            imageView.isHidden = false
            titleLabel.isHidden = false
            subtitleLabel.isHidden = false
            button.isHidden = false
            indicatorView.stopAnimating()
        case .success:
            hide()
            indicatorView.stopAnimating()
        }
    }
    
}

extension DefaultPlaceholder {
    public struct Context {
        public let indicatorView: InstagramActivityIndicator
        public let imageView: UIImageView
        public let titleLabel: UILabel
        public let subtitleLabel: UILabel
        public let button: DefaultPlaceholder.TryButton
    }
    
    public class TryButton: UIControl {
        public let label: UILabel = .init()
        init() {
            super.init(frame: .zero)
            initialize()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func initialize() {
            addSubview(label)
            label.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.bottom.equalToSuperview()
            }
            clipsToBounds = true
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = frame.height/2
        }
    }
}
