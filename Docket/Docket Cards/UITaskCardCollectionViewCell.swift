//
//  UITaskCard.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

class UITaskCardCollectionViewCell: UICollectionViewCell, UIStandardCardViewDelegate {
	static var standardHeight: CGFloat { return 56 }
	var content: UIStandardCardView?
	
	override func didMoveToSuperview() {
		guard superview != nil else { return }
		addPadding(top: 0, left: padding.medium, bottom: 0, right: padding.medium)
		clipsToBounds = false
		content = UIStandardCardView(rememberToCallFunction_configureCard__addTo: self)
		content!.configureCard {
			content!.resize(width: boundingAreas.widthMinusPadding, height: nil)
			content!.move(x: origins.center, y: nil)
		}
	}
	
	override func prepareForReuse() {
		//if let content = content { content.isHidden = false }
	}
}
