//
//  MultiTextField.swift
//  AtomicUISample
//
//  Created by Brian Thomas on 2/1/15.
//  Copyright (c) 2015 Brian Thomas. All rights reserved.
//

import Foundation
import Architect

@objc public class MultiTextField: UIView {
    
    public var numberOfTextFields: Int = 2
    public var borderColor: UIColor = UIColor.grayColor()
    public var textFields: [UITextField] = []
    
    private var fieldLayerCollection: [(field: UITextField, mask: CALayer, border: CALayer)] = []
    private var borderLayer: CALayer?
    private var maskLayer: CALayer?
    
    override init() {
        super.init()
        sharedInitializer()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitializer()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitializer()
    }
    
    public init(frame: CGRect, numberOfFields: Int, borderColor color: UIColor) {
        numberOfTextFields = numberOfFields
        borderColor = color
        super.init(frame: frame)
    }
    
    func sharedInitializer () {
        for index in 0..<numberOfTextFields {
            var textField = textFieldWithLeftSpacingView()
            var cornerOptions: UIRectCorner?
            switch index {
            case 0:
                cornerOptions = UIRectCorner.TopLeft | UIRectCorner.TopRight
            case 1..<numberOfTextFields - 1:
                cornerOptions = UIRectCorner.allZeros
            case numberOfTextFields - 1:
                cornerOptions = UIRectCorner.BottomLeft | UIRectCorner.BottomRight
            default:
                cornerOptions = UIRectCorner.TopLeft | UIRectCorner.TopRight
            }
            let path = UIBezierPath(roundedRect: textField.bounds, byRoundingCorners: cornerOptions!, cornerRadii: CGSize(width: 4, height: 4))
            textField.layer.mask = maskLayer(path)
            textField.layer.addSublayer(borderLayer(path, color: borderColor))
            textFields.append(textField)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        for group in fieldLayerCollection {
            group.mask.frame = group.field.bounds
            group.border.frame = group.field.bounds
        }
    }
    
    func maskLayer(path: UIBezierPath) -> CAShapeLayer {
        let textmaskLayer = CAShapeLayer()
        textmaskLayer.path = path.CGPath
        return textmaskLayer
    }
    
    func borderLayer(path: UIBezierPath, color: UIColor) -> CAShapeLayer {
        let textborderLayer = CAShapeLayer()
        textborderLayer.strokeColor = color.CGColor
        textborderLayer.lineWidth = 0.5
        textborderLayer.fillColor = nil
        textborderLayer.path = path.CGPath
        return textborderLayer
    }
    
    func textFieldWithLeftSpacingView () -> UITextField {
        var textField = UITextField()
        textField.leftViewMode = .Always
        textField.leftView = smallClearView()
        return textField
    }
    
    func smallClearView () -> UIView {
        var spacingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        spacingView.backgroundColor = UIColor.clearColor()
        return spacingView
    }
    
}
