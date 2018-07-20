//
//  NavBar.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit

class UINavMenuBarViewController: UIViewController {
	@IBOutlet weak var menuBarScrollView: UIMenuBarScrollView!
	
	static var MenuBarNavigationTabs: [UIMenuBarTabTypes] {
		return [.docket, .planner, .userProfile, .settings]
	}
	
	override func viewDidLayoutSubviews() {
		menuBarScrollView.setup(withTabs: UINavMenuBarViewController.MenuBarNavigationTabs)
	}
}
