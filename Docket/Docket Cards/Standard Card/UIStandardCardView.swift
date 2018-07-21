//
//  UIStandardCollectionViewCell.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit

class UIStandardCardView: UIView {
	@IBOutlet var Card: UIView!
	@IBOutlet weak var leftGlyph: UIImageView!
	@IBOutlet weak var leftLabel: UILabel!
	@IBOutlet weak var rightLabel: UILabel!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		Bundle.main.loadNibNamed("UIStandardCardView", owner: self, options: nil)
		addSubview(Card)
	}
}
