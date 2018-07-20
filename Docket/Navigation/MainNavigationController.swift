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
	@IBOutlet weak var NavigationCollection: UICollectionView!
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let NAVBAR = segue.destination as? UINavBarViewController {
			NavBar = NAVBAR
		} else { error.regarding(self, explanation: "Could not connect the navbar to Docket Navigation Controller.") }
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		NavigationCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "navigationCell")
		
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
		let cell = NavigationCollection.dequeueReusableCell(withReuseIdentifier: "navigationCell", for: indexPath)
		switch indexPath.row {
		case 0:
			cell.backgroundColor = UIColor.blue
			break
		case 1:
			cell.backgroundColor = UIColor.redBrown
			break
		case 2:
			cell.backgroundColor = UIColor.gray
			break
		case 3:
			cell.backgroundColor = UIColor.brown
			break
		default:
			break
		}
		return cell
	}
}

extension UIMainNavigationController: UICollectionViewDelegateFlowLayout {
	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		guard let NavBar = NavBar else { return }
		var i = (NavigationCollection.contentOffset.x / NavigationCollection.frame.width)
		i.round()
		NavBar.MenuBar.switchToTab(NavBar.MenuBar.tabs[Int(i)])
	}
	func moveToNavigationCollectionCell(at index: Int) {
		NavigationCollection.setContentOffset(CGPoint(x: NavigationCollection.frame.width * CGFloat(index), y: 0), animated: true)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return NavigationCollection.frame.size
	}
}
