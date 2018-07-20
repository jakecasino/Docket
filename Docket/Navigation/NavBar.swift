//
//  NavBar.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit

class UINavMenuBarViewController: UIViewController {
	@IBOutlet weak var MenuBar: UIMenuBar!
	
	static var MenuBarNavigationTabs: [UIMenuBarTabTypes] {
		return [.docket, .planner, .userProfile, .settings]
	}
	
	override func viewDidLayoutSubviews() {
		MenuBar.setup(withTabs: UINavMenuBarViewController.MenuBarNavigationTabs)
	}
}
