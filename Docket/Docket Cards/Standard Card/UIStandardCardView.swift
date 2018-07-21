//
//  UIStandardCollectionViewCell.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

protocol UIStandardCardViewDelegate {
	var content: UIStandardCardView? { get set }
}

class UIStandardCardView: UIView {
	@IBOutlet var Card: UIView!
	@IBOutlet weak var leftGlyph: UIImageView!
	@IBOutlet weak var leftLabel: UILabel!
	@IBOutlet weak var rightLabel: UILabel!
	
	convenience init(in view: UIView) {
		self.init(frame: .zero)
		view.addSubview(self)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		loadXib()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadXib()
	}
	
	override func didMoveToSuperview() {
		guard superview != nil else { return }
		resize(width: boundingAreas.width, height: boundingAreas.height)
		style(self, [.corners: corners.extraLarge, .maskContent: true])
		dropShadow(opacity: 0.3, x: 0, y: 4, blur: 16, spread: -8)
	}
	
	func loadXib() {
		loadXib(named: "UIStandardCardView")
		setupXibView(Card, inContainer: self)
	}
}
