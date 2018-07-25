//
//  NavController.swift
//  Docket
//
//  Created by Jake Casino on 12/13/17.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

class UINavBarViewController: UIViewController { @IBOutlet weak var menuBar: UIMenuBar! }

class UIMainNavigationController: UIMenuBarTabsCollectionViewController {
	@IBOutlet weak var navBarView: UIView!
	var navBarViewController: UINavBarViewController?
	@IBOutlet weak var tabsCollectionView_fromInterfaceBuilder: UICollectionView!
	
	@IBOutlet weak var assistantInteractionBarView: UIAssistantInteractionBarView!
	var assistantCardView: UIAssistantCardView!
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let NAVBAR = segue.destination as? UINavBarViewController {
			navBarViewController = NAVBAR
		} else { error.regarding(self, explanation: "Could not connect the navbar to Docket Navigation Controller.") }
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Link and style the Tab Collection View
		tabsCollectionView = tabsCollectionView_fromInterfaceBuilder
		style(tabsCollectionView, [.backgroundColor: UIColor.whiteF8])
		
		//Set up the Menu Bar Tabs
		menuBarNavigationTabs = [.docket, .planner, .userProfile, .settings]
		menuBar = navBarViewController!.menuBar
		menuBar.setup(tabs: menuBarNavigationTabs, tabsDelegate: self)
		menuBarTabsRegistration()
		
		assistantCardView = UIAssistantCardView(addTo: view, interactionBar: assistantInteractionBarView, heightWhenMaximized: view.frame.height - navBarView.frame.height - padding.medium)
		assistantCardView.changeState(to: .minimized)
		
		menuBar.assistantCardView = assistantCardView
		assistantInteractionBarView.assistantCardView = assistantCardView
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
