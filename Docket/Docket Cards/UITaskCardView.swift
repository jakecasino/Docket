//
//  UITaskCard.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

class UITaskCardView: UIView, UIStandardCardViewDelegate {
	static var standardHeight: CGFloat { return 56 }
	var content: UIStandardCardView?
	
	convenience init(in view: UIView) {
		self.init(addTo: view)
		view.addPadding(top: 0, left: padding.medium, bottom: 0, right: padding.medium)
		resize(width: boundingAreas.widthMinusPadding, height: UITaskCardView.standardHeight)
		move(x: origins.center, y: nil)
		content = UIStandardCardView(in: self)
	}

}
