//
//  ViewController.swift
//  Docket
//
//  Created by Jake Casino on 12/13/17.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

class UIMainNavigationController: UIViewController {
	var NavBar: UINavBarViewController?
	@IBOutlet weak var TabCollection: UICollectionView!
	private let ID_Docket = "Docket"
	private let ID_Planner = "Planner"
	private let ID_UserProfile = "User Profile"
	private let ID_Settings = "Settings"
	
	// For determining scroll direction
	private var lastContentOffset: CGFloat = 0
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let NAVBAR = segue.destination as? UINavBarViewController {
			NavBar = NAVBAR
		} else { error.regarding(self, explanation: "Could not connect the navbar to Docket Navigation Controller.") }
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		TabCollection.register(UIDocketTabCollectionViewCell.self, forCellWithReuseIdentifier: ID_Docket)
		TabCollection.register(UIPlannerTabCollectionViewCell.self, forCellWithReuseIdentifier: ID_Planner)
		TabCollection.register(UIUserProfileTabCollectionViewCell.self, forCellWithReuseIdentifier: ID_UserProfile)
		TabCollection.register(UISettingsTabCollectionViewCell.self, forCellWithReuseIdentifier: ID_Settings)
		lastContentOffset = TabCollection.contentOffset.x
		
		guard let NavBar = NavBar else { return }
		NavBar.MenuBar.MainNavigation = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UIMainNavigationController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return UINavBarViewController.MenuBarNavigationTabs.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let errorTabView = TabCollection.dequeueReusableCell(withReuseIdentifier: ID_Docket, for: indexPath)
		guard let NavBar = NavBar else { return errorTabView}
		
		switch NavBar.MenuBar.tabs[indexPath.row].tabType {
		case .docket:
			let tabView = TabCollection.dequeueReusableCell(withReuseIdentifier: ID_Docket, for: indexPath) as! UIDocketTabCollectionViewCell
			return tabView
		case .planner:
			let tabView = TabCollection.dequeueReusableCell(withReuseIdentifier: ID_Planner, for: indexPath) as! UIPlannerTabCollectionViewCell
			tabView.backgroundColor = UIColor.redBrown
			return tabView
		case .userProfile:
			let tabView = TabCollection.dequeueReusableCell(withReuseIdentifier: ID_UserProfile, for: indexPath) as! UIUserProfileTabCollectionViewCell
			tabView.backgroundColor = UIColor.brown
			return tabView
		case .settings:
			let tabView = TabCollection.dequeueReusableCell(withReuseIdentifier: ID_Settings, for: indexPath) as! UISettingsTabCollectionViewCell
			tabView.backgroundColor = UIColor.yellow
			return tabView
		default:
			return errorTabView
		}
	}
}

extension UIMainNavigationController: UICollectionViewDelegateFlowLayout {
	func moveToNavigationCollectionCell(at index: Int) {
		TabCollection.setContentOffset(CGPoint(x: TabCollection.frame.width * CGFloat(index), y: 0), animated: true)
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		lastContentOffset = TabCollection.contentOffset.x
	}
	
	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		let currentContentOffset = TabCollection.contentOffset.x
		
		guard let NavBar = NavBar else { return }
		if (currentContentOffset > lastContentOffset) {
			NavBar.MenuBar.switchToTab(.next)
		} else if currentContentOffset < lastContentOffset {
			NavBar.MenuBar.switchToTab(.previous)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return TabCollection.frame.size
	}
}
