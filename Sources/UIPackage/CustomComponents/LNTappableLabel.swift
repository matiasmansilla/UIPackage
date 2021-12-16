//
//  LNTappableLabel.swift
//
//
//  Created by Alejandro Castillo on 24/11/2021.
//

import Foundation
import UIKit

@IBDesignable
public class LNTappableLabel: UILabel {
    public var handleTap: (() -> Void)?
    private var range: NSRange?
    private var tapText: String?
    private var initialAttributesBeforeTouch: NSAttributedString?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func setupTappableLabel(textToTap: String?, handleTap: @escaping ( () -> Void )) {
        tapText = textToTap
        range = self.text?.range(of: tapText ?? "")?.nsRange
        self.handleTap = handleTap
    }
    
    private func commonInit() {
        isUserInteractionEnabled = true
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        recognizer.minimumPressDuration = 0.0
        addGestureRecognizer(recognizer)
    }
    
    @objc private func longPressed(_ sender: UILongPressGestureRecognizer) {
        guard let range = range else { return }
        if sender.didTapAttributedTextInLabel(label: self, inRange: range), sender.state == .began {
            highlight()
        }
        if sender.didTapAttributedTextInLabel(label: self, inRange: range), sender.state == .ended {
            unhighlight()
            handleTap?()
        }
    }
    
    private func highlight() {
        guard let range = range, let attributedText = attributedText else { return }
        initialAttributesBeforeTouch = attributedText
        let auxiliaryAttributes = NSMutableAttributedString(attributedString: attributedText)
        let foregroundColorAuxiliary = attributedText.attributedSubstring(from: range).attribute(NSAttributedString.Key.foregroundColor, at: 0, longestEffectiveRange: nil, in: range) as? UIColor
        auxiliaryAttributes.addAttribute(NSAttributedString.Key.foregroundColor, value: foregroundColorAuxiliary?.withAlphaComponent(0.5) ?? UIColor.black, range: range)
        self.attributedText = auxiliaryAttributes
    }
    
    private func unhighlight() {
        attributedText = initialAttributesBeforeTouch
    }
}
