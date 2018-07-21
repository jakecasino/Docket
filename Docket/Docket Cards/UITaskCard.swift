//
//  UITaskCard.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit

class UITaskCard: UIView {
	@IBOutlet var View: UIView!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		Bundle.main.loadNibNamed("UITaskCardView", owner: self, options: nil)
		addSubview(View)
	}

}
