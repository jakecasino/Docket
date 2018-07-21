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
	var content: UIStandardCardView?
	
	convenience init(in view: UIView) {
		self.init(addTo: view)
		resize(width: view.frame.width - padding.large, height: 56)
		move(x: origins.center, y: nil)
		content = UIStandardCardView(in: self)
	}

}
