//
//  ProjectPageViewController.swift
//  Docket
//
//  Created by Jake Casino on 7/22/18.
//

import UIKit

class ProjectPageViewController: UIMenuBarTabsCollectionViewController {
	@IBOutlet var menuBar_fromInterfaceBuilder: UIMenuBar!
	@IBOutlet var tabsCollectionView_fromInterfaceBuilder: UICollectionView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Link and style the Tab Collection View
		tabsCollectionView = tabsCollectionView_fromInterfaceBuilder
		style(tabsCollectionView, [.backgroundColor: UIColor.whiteF8])
		
		//Set up the Menu Bar Tabs
		menuBarNavigationTabs = [.docket, .planner, .userProfile, .settings]
		menuBar = menuBar_fromInterfaceBuilder
		menuBar.setup(tabs: menuBarNavigationTabs, tabsDelegate: self)
		menuBarTabsRegistration()
    }
}
