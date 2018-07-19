//
//  ViewController.swift
//  Docket
//
//  Created by Jake Casino on 12/13/17.
//  Copyright © 2018 Jake Casino, Inc. All rights reserved.
//

import UIKit
import Efficio

class DocketViewController: UIViewController {
	@IBOutlet weak var menuBar: UIView!
	

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewDidLayoutSubviews() {
		menuBar.move(x: origins.left, y: origins.top)
		menuBar.resize(width: boundingAreas.width, height: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
