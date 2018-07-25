//
//  AssistantViewController.swift
//  Docket
//
//  Created by Jake Casino on 7/23/18.
//

import UIKit
import Efficio

class UIAssistantInteractionBarView: UIView {
	@IBOutlet var view: UIView!
	@IBOutlet weak var micButton: UIAction!
	@IBOutlet weak var keyboardButton: UIAction!
	@IBOutlet weak var addButton: UIAction!
	var assistantCardView: UIAssistantCardView!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		loadXib(named: "UIAssistantInteractionBarView")
		setupXibView(view, inContainer: self)
		
		let primaryButtonGlyphEdgeInsets: CGFloat = 11
		let secondaryButtonGlyphEdgeInsets: CGFloat = 5
		
		micButton.imageEdgeInsets = UIEdgeInsets(top: primaryButtonGlyphEdgeInsets, left: primaryButtonGlyphEdgeInsets, bottom: primaryButtonGlyphEdgeInsets, right: primaryButtonGlyphEdgeInsets)
		micButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapMicButton(_:))))
		
		keyboardButton.imageEdgeInsets = UIEdgeInsets(top: secondaryButtonGlyphEdgeInsets, left: secondaryButtonGlyphEdgeInsets, bottom: secondaryButtonGlyphEdgeInsets, right: secondaryButtonGlyphEdgeInsets)
		
		addButton.imageEdgeInsets = UIEdgeInsets(top: secondaryButtonGlyphEdgeInsets, left: secondaryButtonGlyphEdgeInsets, bottom: secondaryButtonGlyphEdgeInsets, right: secondaryButtonGlyphEdgeInsets)
		addButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAddButton(_:))))
		
	}
	
	@objc func tapMicButton(_ sender: UITapGestureRecognizer) {
		micButton.toggle(inactiveState: {
			assistantCardView.changeState(to: .minimized)
		}) {
			assistantCardView.changeState(to: .maximized)
		}
	}
	
	@objc func tapAddButton(_ sender: UITapGestureRecognizer) {
		addButton.toggle(inactiveState: {
			assistantCardView.changeState(to: .minimized)
			UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
				self.addButton.transform = self.addButton.transform.rotated(by: -(CGFloat(CGFloat.pi / 4)))
			})
			UIView.animate(withDuration: 0.3, animations: {
				self.micButton.alpha = 1
				self.keyboardButton.alpha = 1
			})
		}) {
			assistantCardView.changeState(to: .maximized)
			UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
				self.addButton.transform = self.addButton.transform.rotated(by: CGFloat(CGFloat.pi / 4))
			})
			UIView.animate(withDuration: 0.3, animations: {
				self.micButton.alpha = 0.3
				self.keyboardButton.alpha = 0.3
			})
		}
	}
}
