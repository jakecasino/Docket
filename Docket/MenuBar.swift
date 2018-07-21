//
//  DKTMenuBarViewController.swift
//  Docket
//
//  Created by Jake Casino on 7/18/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

enum UIMenuBarTabTypes {
	case docket
	case planner
	case userProfile
	case settings
	case updates
	case tasks
	case files
	case team
	case about
}

class UIMenuBar: UIScrollView {
	var tabs = [UIMenuBarTabLabel]()
	var tabSelector = UIView()
	var MainNavigation: UIMainNavigationController?
	var selectedMenuBarTab: UIMenuBarTabLabel?
	
	func setup(withTabs tabsToAdd: [UIMenuBarTabTypes]) {
		var estimatedContentWidth: CGFloat = 0
		contentInset = UIEdgeInsets(top: 0, left: padding.medium, bottom: 0, right: padding.medium)
		clipsToBounds = false
		
		tabSelector = UIView(addTo: self)
		style(tabSelector, [.backgroundColor: UIColor.redBrown, .corners: corners.large])
		tabSelector.dropShadow(opacity: 0.3, x: 0, y: 4, blur: 16, spread: -4)
		
		for (index, tabToAdd) in tabsToAdd.enumerated() {
			
			let tabLabel = UIMenuBarTabLabel(addTo: self, tabType: tabToAdd, constrainWidthTo: boundingArea(boundingAreas.width))
			
			var xOrigin: CGFloat = 0
			if tabs.isEmpty {
				switchToTab(tabLabel)
				
				tabSelector.matchFrame(to: tabLabel)
				tabSelector.move(x: nil, y: origins.middle)
				
			} else {
				let previousTab = tabs[index - 1]
				xOrigin += (previousTab.frame.origin.x + previousTab.frame.width + padding.small)
				estimatedContentWidth += padding.small
			}
			
			estimatedContentWidth += tabLabel.frame.width
			
			tabLabel.move(x: xOrigin, y: origins.middle)
			tabLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabWasSelected(_:))))
			tabs.append(tabLabel)
		}
		
		contentSize = CGSize(width: estimatedContentWidth, height: frame.height)
	}
	
	@objc func tabWasSelected(_ sender: UITapGestureRecognizer) {
		guard let selectedMenuBarTab = sender.view as? UIMenuBarTabLabel else { return }
		switchToTab(selectedMenuBarTab)
	}
	
	func switchToTab(_ SELECTEDTAB: UIMenuBarTabLabel) {
		
		// Disable already activated Menu Bar Tab and enable selected one
		tabs.forEach { if $0.isEnabled { $0.toggle() } }
		SELECTEDTAB.toggle()
		selectedMenuBarTab = SELECTEDTAB
		
		UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
			
			var newContentOffset: CGFloat = 0
			for (index, tab) in self.tabs.enumerated() {
				
				if tab.isEnabled {
					
					// Move scrollview to appropriate position
					newContentOffset = (self.contentSize.width - self.bounds.width) * (((CGFloat(index) + 0.5) / CGFloat(self.tabs.count)))
					
					if index == 0 { newContentOffset = -(padding.medium) }
					else if index == (self.tabs.count - 1) { newContentOffset = (self.contentSize.width - self.bounds.width) + padding.medium }
					else if index <= (self.tabs.count / 2) { newContentOffset -= padding.medium }
					else { newContentOffset += padding.medium }
					self.contentOffset = CGPoint(x: newContentOffset, y: 0)
					
					// Select appropriate navigation collection cell
					guard let AppNavigation = self.MainNavigation else { return }
					AppNavigation.moveToNavigationCollectionCell(at: index)
				}
				
				// Realign all Menu Bar tabs
				if self.tabs.indices.contains(index - 1) {
					let previousTab = self.tabs[index - 1]
					tab.move(x: previousTab.frame.origin.x + previousTab.frame.width + padding.small, y: nil)
				}
			}
			
			// Move the Tab Selector
			self.tabSelector.matchFrame(to: self.selectedMenuBarTab!)
		})
	}
	
	enum tabDirections {
		case next
		case previous
	}
	
	func switchToTab(_ tabDirection: tabDirections) {
		guard let selectedMenuBarTab = selectedMenuBarTab else { return }
		if let currentIndex = tabs.firstIndex(of: selectedMenuBarTab) {
			switch tabDirection {
			case .next:
				let nextIndex = currentIndex + 1
				if tabs.indices.contains(nextIndex) { switchToTab(tabs[nextIndex]) }
				break
			case .previous:
				let prevIndex = currentIndex - 1
				if tabs.indices.contains(prevIndex) { switchToTab(tabs[prevIndex]) }
				break
			}
		}
	}
	
	class UIMenuBarTabLabel: UILabel {
		static var tabFontSize: CGFloat { return 17 }
		static var paddingWhenSelected: CGFloat { return padding.medium * 2 }
		var tabType: UIMenuBarTabTypes = .updates
		
		convenience init(addTo view: UIView, tabType TAB_TYPE: UIMenuBarTabTypes, constrainWidthTo width: CGFloat) {
			
			// Choose appropriate text for label
			let tabLabelText: String
			switch TAB_TYPE {
				case .docket: tabLabelText = "Docket"; break
				case .planner: tabLabelText = "Planner"; break
				case .userProfile: tabLabelText = "User Profile"; break
				case .settings: tabLabelText = "Settings"; break
				case .updates: tabLabelText = "Updates"; break
				case .tasks: tabLabelText = "Tasks"; break
				case .files: tabLabelText = "Files"; break
				case .team: tabLabelText = "Team"; break
				case .about: tabLabelText = "About"; break
			}
			
			self.init(addTo: view, text: tabLabelText, font: UIFont.systemFont(ofSize: UIMenuBarTabLabel.tabFontSize), constrainWidthTo: width, numberOfLines: 1)
			tabType = TAB_TYPE
			resize(addToWidth: (padding.small * 2), addToHeight: (padding.small * 2))
			textAlignment = .center
			isUserInteractionEnabled = true
			isEnabled = false
		}
		
		func toggle() {
			if isEnabled {
				isEnabled = false
				textColor = UIColor.black
				font = UIFont.systemFont(ofSize: UIMenuBarTabLabel.tabFontSize)
				resize(addToWidth: -(UIMenuBarTabLabel.paddingWhenSelected), addToHeight: nil)
			} else {
				isEnabled = true
				textColor = UIColor.white
				font = UIFont.boldSystemFont(ofSize: UIMenuBarTabLabel.tabFontSize)
				resize(addToWidth: UIMenuBarTabLabel.paddingWhenSelected, addToHeight: nil)
			}
		}
	}
}
