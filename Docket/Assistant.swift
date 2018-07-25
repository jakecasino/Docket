//
//  Machine Learning Algorithm.swift
//  Docket
//
//  Created by Jake Casino on 7/19/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

let Assistant = DocketAssistantModel()

class DocketAssistantModel {
	var targetWorkHours: Double?
	var targetSleepHours: Double?
	
	fileprivate init() { }
	
	func chooseProjectsAndTasksToWorkOn() -> Any? {
		return nil
	}
	
	func estimateTimeForBreakfast() {
		
	}
	
	func estimateTimeForLunch() {
		
	}
	
	func estimateTimeForDinner() {
		
	}
	
	func estimateTimeForSleep() {
		
	}
	
}

class UIAssistantCardView: UIView {
	var handleGrabber: UIAction!
	var heightWhenMinimized: CGFloat!
	var heightWhenMaximized: CGFloat!
	var lastOriginY: CGFloat!
	
	enum states {
		case minimized
		case maximized
	}
	
	convenience init(addTo view: UIView, interactionBar: UIAssistantInteractionBarView, heightWhenMaximized HEIGHT_WHEN_MAXIMIZED: CGFloat) {
		self.init(frame: .zero)
		view.insertSubview(self, belowSubview: interactionBar)
		
		func setupHandle() {
			let handleWidth: CGFloat = 48
			let handleHeight: CGFloat = 6
			
			let handle = UIView(addTo: self)
			handle.resize(width: 48, height: handleHeight)
			handle.move(x: origins.center, y: padding.small)
			style(handle, [.backgroundColor: UIColor(white: 0, alpha: 0.08), .corners: corners.roundByHeight])
			
			handleGrabber = UIAction(addTo: self)
			handleGrabber.resize(addToWidth: handleWidth, addToHeight: handleHeight * 8)
			handleGrabber.move(x: origins.center, y: origins.top)
			handleGrabber.backgroundColor = UIColor.clear
			handleGrabber.tintColor = UIColor.clear
			handleGrabber.baseColor = handleGrabber.backgroundColor!
			handleGrabber.accentColor = handleGrabber.tintColor
			handleGrabber.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAssistantCardViewHandle(_:))))
			handleGrabber.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panAssistantCardView(_:))))
		}
		
		resize(width: boundingAreas.width, height: interactionBar.frame.height + padding.medium)
		move(x: nil, y: origins.bottom)
		style(self, [.backgroundColor: UIColor.white, .corners: 24])
		dropShadow(opacity: 0.3, x: 0, y: 0, blur: 8, spread: -4)
		setupHandle()
		
		heightWhenMinimized = frame.height
		heightWhenMaximized = HEIGHT_WHEN_MAXIMIZED
	}
	
	func changeState(to state: states) {
		let height: CGFloat
		switch state {
		case .minimized:
			height = heightWhenMinimized
			if handleGrabber.isSelected { handleGrabber.isSelected = false }
		case .maximized:
			height = heightWhenMaximized
			if !handleGrabber.isSelected { handleGrabber.isSelected = true }
		}
		
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
			
			self.resize(width: nil, height: height)
			self.move(x: nil, y: origins.bottom)
		})
		
		lastOriginY = frame.origin.y
	}
	
	@objc func tapAssistantCardViewHandle(_ sender: UITapGestureRecognizer) {
		handleGrabber.toggle(inactiveState: {
			changeState(to: .minimized)
		}) {
			changeState(to: .maximized)
		}
	}
	
	@objc func panAssistantCardView(_ sender: UIPanGestureRecognizer) {
		guard let superview = superview else { return }
		
		let translation = sender.translation(in: self)
		if (frame.origin.y + translation.y) < (superview.frame.height - heightWhenMinimized) {
			move(addToX: nil, addToY: translation.y)
			resize(addToWidth: nil, addToHeight: -(translation.y))
			sender.setTranslation(CGPoint.zero, in: self)
		}
		
		if sender.state == .ended {
			if frame.origin.y < lastOriginY { changeState(to: .maximized) }
			else { changeState(to: .minimized) }
		}
	}
}
