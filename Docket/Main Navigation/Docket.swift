//
//  Docket.swift
//  Docket
//
//  Created by Jake Casino on 7/20/18.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import  Efficio

class UIDocketTabCollectionViewCell: UICollectionViewCell, UINestedCollectionView  {
	var collectionView: UICollectionView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		collectionView = UICollectionView(addTo: self, sectionInset: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
		collectionView.resize(toFit: self)
		style(collectionView, [.backgroundColor: UIColor.whiteF8])
		
		collectionView.register(UITaskCardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension UIDocketTabCollectionViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 50
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let card = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UITaskCardCollectionViewCell
		return card
	}
	
	
}

extension UIDocketTabCollectionViewCell: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: boundingArea(.width), height: UITaskCardCollectionViewCell.standardHeight)
	}
}
