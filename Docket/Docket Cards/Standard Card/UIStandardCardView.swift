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
	var content: UIStandardCardView! { get set }
}

class UIStandardCardView: UIView {
	@IBOutlet var Card: UIView!
	@IBOutlet weak var leftGlyph: Glyph!
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
		guard let superview = superview else { return }
		resize(toFit: superview)
		style(self, [.corners: corners.extraLarge, .maskContent: true, .borderColor: UIColor(white: 0, alpha: 0.08), .borderWidth: 0.5])
		leftGlyph.render(Glyphs.calendar, tintColor: UIColor.red)
	}
	
	func configureCard(setupFrame: () -> ()) {
		setupFrame()
		dropShadow(opacity: 0.3, x: 0, y: 4, blur: 16, spread: -8)
	}
	
	func loadXib() {
		loadXib(named: "UIStandardCardView")
		setupXibView(Card, inContainer: self)
	}
}
