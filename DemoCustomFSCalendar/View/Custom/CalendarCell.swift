//
//  CalendarCell.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 8/10/2564 BE.
//

import Foundation
import UIKit
import FSCalendar

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}


class CalendarCell: FSCalendarCell {

    weak var selectionLayer: CAShapeLayer!
    weak var roundedLayer: CAShapeLayer!
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    var selectionColor: UIColor = .white {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor.white.cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel?.layer)
        self.selectionLayer = selectionLayer
        
        let roundedLayer = CAShapeLayer()
        roundedLayer.fillColor = UIColor.white.cgColor
        roundedLayer.actions = ["hidden": NSNull()]
        self.contentView.layer.insertSublayer(roundedLayer, below: self.titleLabel?.layer)
        self.roundedLayer = roundedLayer
        
        self.shapeLayer.isHidden = true
        let view = UIView(frame: self.bounds)
        self.backgroundView = view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundView?.frame = self.bounds.insetBy(dx: 1, dy: 1)
        self.roundedLayer.frame = self.contentView.bounds
        self.selectionLayer.frame = self.contentView.bounds
        
        self.titleLabel.frame = self.contentView.frame
        
        switch selectionType {
        case .middle:
            displayMiddle()
        case .leftBorder:
            displayLeftBorder()
        case .rightBorder:
            displayRightBorder()
        case .single:
            displaySingle()
        case .none:
            displayNone()
        }
    }
    
    func displaySingle() {
        self.selectionLayer?.isHidden = true
        self.roundedLayer?.isHidden = false
        let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
        self.roundedLayer?.path = UIBezierPath(ovalIn: CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)).cgPath
        self.roundedLayer.fillColor = selectionColor.cgColor
    }
    
    func displayNone() {
        self.roundedLayer?.isHidden = true
        self.roundedLayer.fillColor = UIColor.white.cgColor
        self.selectionLayer?.isHidden = true
        self.selectionLayer.fillColor = UIColor.white.cgColor
    }
    
    func displayMiddle() {
        self.selectionLayer?.isHidden = false
        self.selectionLayer?.path = UIBezierPath(rect: selectionLayer.bounds).cgPath
        self.selectionLayer.fillColor = selectionColor.withAlphaComponent(0.35).cgColor
        self.roundedLayer?.isHidden = true
    }
    
    func displayRightBorder() {
        let selectionRect = selectionLayer.bounds.insetBy(dx: selectionLayer.frame.width / 4, dy: 0.0).offsetBy(dx: -selectionLayer.frame.width / 4, dy: 0.0)
        self.selectionLayer?.isHidden = false
        self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath
        self.selectionLayer.fillColor = selectionColor.withAlphaComponent(0.35).cgColor

        let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
        let rect = CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)
        self.roundedLayer?.isHidden = false
        self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath
        self.roundedLayer.fillColor = selectionColor.cgColor
    }
    
    func displayLeftBorder() {
        let selectionRect = selectionLayer.bounds.insetBy(dx: selectionLayer.frame.width / 4, dy: 0.0).offsetBy(dx: selectionLayer.frame.width / 4, dy: 0.0)
        self.selectionLayer?.isHidden = false
        self.selectionLayer?.path = UIBezierPath(rect: selectionRect).cgPath
        self.selectionLayer.fillColor = selectionColor.withAlphaComponent(0.35).cgColor

        let diameter: CGFloat = min(roundedLayer.frame.height, roundedLayer.frame.width)
        let rect = CGRect(x: self.contentView.frame.width / 2 - diameter / 2, y: self.contentView.frame.height / 2 - diameter / 2, width: diameter, height: diameter)
        self.roundedLayer?.isHidden = false
        self.roundedLayer?.path = UIBezierPath(ovalIn: rect).cgPath
        self.roundedLayer.fillColor = selectionColor.cgColor

    }
    
    override func configureAppearance() {
        super.configureAppearance()
        // Override the build-in appearance configuration
        if self.isPlaceholder {
            self.eventIndicator.isHidden = true
        }
    }
}
