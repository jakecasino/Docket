//
//  Planner.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

class UIPlannerTabCollectionViewCell: UICollectionViewCell, UINestedCollectionView {
	var collectionView: UICollectionView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		collectionView = UICollectionView(addTo: self, sectionInset: UIEdgeInsets(top: padding.medium, left: 0, bottom: padding.extraLarge, right: 0))
		collectionView.resize(toFit: self)
		style(collectionView, [.backgroundColor: UIColor.whiteF8])
		
		collectionView.register(UITaskCardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.showsVerticalScrollIndicator = false
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension UIPlannerTabCollectionViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 50
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let card = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UITaskCardCollectionViewCell
		return card
	}
}

extension UIPlannerTabCollectionViewCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: boundingArea(.width), height: UITaskCardCollectionViewCell.standardHeight)
	}
}
